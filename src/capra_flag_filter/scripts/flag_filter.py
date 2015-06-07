#!/usr/bin/env python
# coding=utf-8

PACKAGE = 'capra_flag_filter'
IMAGE_TOPIC = '/image_raw_throttle'

import roslib
roslib.load_manifest(PACKAGE)
import rospy
import rospkg
from sensor_msgs.msg import Image
import cv2
import numpy as np
from cv_bridge import CvBridge
from capra_flag_filter.cfg import FlagFilterConfig
from dynamic_reconfigure.server import Server


class FlagFilter:
    last_image = None
    perspective_matrix = None
    update_perspective_matrix = True
    rectangle_left_x = 250
    rectangle_left_y = 300
    rectangle_right_x = 400
    rectangle_right_y = 400
    perspective_bottom_left_x = 176.0
    perspective_bottom_left_y = 253.0
    perspective_bottom_right_x = 393.0
    perspective_bottom_right_y = 253.0
    perspective_top_left_x = -127.0
    perspective_top_left_y = 61.0
    perspective_top_right_x = 699.0
    perspective_top_right_y = 63.0
    perspective_translation_x = -47.0
    perspective_translation_y = 35.0
    perspective_zoom = 166.0
    blue_min_hue = 115
    blue_max_hue = 124
    blue_min_saturation = 191
    blue_max_saturation = 255
    blue_min_value = 141
    blue_max_value = 255
    red_min_hue = 142
    red_max_hue = 255
    red_min_saturation = 83
    red_max_saturation = 255
    red_min_value = 0
    red_max_value = 255
    line_stripe_width = 300
    line_length = 300
    display_raw_image = False
    display_rectangle_image = False
    display_thresholded_image = False
    display_points_image = False
    display_undistorted_image = False
    display_perspective_image = False
    display_lines_image = False
    initialized = False

    def __init__(self):
        rospy.init_node('capra_flag_filter')
        self.parameter_server = Server(FlagFilterConfig, self._parameter_callback)

        self.ellipse_mask = None
        self.distCoeffs = np.array([-0.34, 0.085, 0, 0, -0.007])
        self.cameraMatrix = np.matrix([[630.79035702238025/2, 0, 645.50000000000000/2],
                                       [0, 630.79035702238025/2, 366.50000000000000/2],
                                       [0,                  0,                  1]])
        self.bridge = CvBridge()
        rospy.Subscriber(IMAGE_TOPIC, Image, self._image_callback)
        rospy.Timer(rospy.Duration(0.1), self._filter_callback)
        rospy.spin()
        cv2.destroyAllWindows()

    def _save_config(self, config):
        rospy.loginfo("Saving configuration to %s..." % config.filename)
        try:
            lines = []
            for parameter in sorted(config):
                if parameter in ["save", "groups"]:
                    continue
                lines.append("%s: %s" % (parameter, str(config[parameter])))
            rospack = rospkg.RosPack()
            with open(rospack.get_path(PACKAGE) + '/' + config.filename, "w") as f:
                f.write("\n".join(lines))
        except Exception as ex:
            rospy.logerr("Could not save configuration file: %s" % str(ex.message))

    def _parameter_callback(self, config, level):
        for parameter, value in config.items():
            if hasattr(self, parameter):
                if getattr(self, parameter) != value:
                    rospy.loginfo("Updating %s: %s" % (parameter, str(value)))
                    setattr(self, parameter, value)
                    if parameter.startswith("perspective_"):
                        self.update_perspective_matrix = True

        if config.save and self.initialized:
            config.save = False
            self._save_config(config)

        self.initialized = True
        return config

    def _get_ellipse_mask(self, width, height):
        if self.ellipse_mask is None:
            self.ellipse_mask = np.zeros((height, width, 1), dtype=np.uint8)
            cv2.ellipse(self.ellipse_mask, (width/2 - 20, 370), (350, 320), 0, 360, 180, (255,), -1)
        return self.ellipse_mask

    def _get_perspective_matrix(self, width, height):
        if self.perspective_matrix is None or self.update_perspective_matrix:
            self.update_perspective_matrix = False
            c1 = np.array([[self.perspective_top_left_x, self.perspective_top_left_y],
                           [self.perspective_bottom_left_x, self.perspective_bottom_left_y],
                           [self.perspective_top_right_x, self.perspective_top_right_y],
                           [self.perspective_bottom_right_x, self.perspective_bottom_right_y]],
                          np.float32)
            c2 = np.array([[0, 0], [0, height], [width, 0], [width, height]], np.float32)
            self.perspective_matrix = cv2.getPerspectiveTransform(c2, c1)

        return self.perspective_matrix

    def _get_threshold_mask(self, hsv, min_range, max_range):
        mask = cv2.inRange(hsv, min_range, max_range)
        kernel = cv2.getStructuringElement(cv2.MORPH_ELLIPSE, (3, 5))
        mask = cv2.erode(mask, kernel, iterations=2)
        mask = cv2.dilate(mask, kernel, iterations=2)
        return mask

    def _get_points(self, mask, min_area):
        contours, hier = cv2.findContours(mask, cv2.RETR_LIST, cv2.CHAIN_APPROX_SIMPLE)
        points = []
        for cnt in contours:
            if min_area < cv2.contourArea(cnt):
                x, y, w, h = cv2.boundingRect(cnt)
                points.append((x + w/2, y + h))

        return points

    def _get_lines(self, points, stripes_width, left=True):
        lines = []
        if len(points) == 0:
            return []

        for p in points:
            if left:
                lines.append(((p[0] - self.line_length, p[1]), p))
            else:
                lines.append((p, (p[0] + self.line_length, p[1])))

        stripes = {}
        for p in points:
            stripe = int(p[0] / stripes_width)
            if not stripe in stripes:
                stripes[stripe] = []
            stripes[stripe].append(p)

        for stripe in stripes.values():
            last_point = None
            for point in sorted(stripe, key=lambda point: point[1]):
                if last_point is not None:
                    lines.append((last_point, point))
                last_point = point

        return lines

    def _find_lines_intersection(self, line1, line2):
        xdiff = (line1[0][0] - line1[1][0], line2[0][0] - line2[1][0])
        ydiff = (line1[0][1] - line1[1][1], line2[0][1] - line2[1][1])

        def det(a, b):
            return a[0] * b[1] - a[1] * b[0]

        div = det(xdiff, ydiff)
        if div == 0:
            return None

        d = (det(*line1), det(*line2))
        x = det(d, xdiff) / div
        y = det(d, ydiff) / div

        return x, y

    def _filter_lines(self, lines1, lines2, points1, points2):
        lines1_2 = np.asarray(lines1)
        lines2_2 = np.asarray(lines2)

        # TODO: Please optimize me.
        # Le but c'est que les lignes horizontales coupent pas les lignes verticales.
        # Ça peut arriver s'il y a du rouge à gauche du bleu.
        for l1 in lines1_2:
            min_x_l1 = min([l1[0][0], l1[1][0]])
            max_x_l1 = max([l1[0][0], l1[1][0]])
            for l2 in lines2_2:
                min_x_l2 = min([l2[0][0], l2[1][0]])
                max_x_l2 = max([l2[0][0], l2[1][0]])
                intersection = self._find_lines_intersection(l1, l2)
                # Ça intersecte pas, donc on continue.
                if intersection is None:
                    continue
                intersection_x, intersection_y = intersection
                # Il y a une intersection et elle est bien située entre les deux lignes.
                if min_x_l1 <= intersection_x <= max_x_l1 and min_x_l2 <= intersection_x <= max_x_l2:
                    # La ligne 1 est horizontale et c'est elle qu'on veut couper.
                    if l1[0][1] == l1[1][1]:
                        if len([p for p in points1 if p[0] == l1[0][0]]) == 0:
                            l1[0][0] = intersection_x
                        else:
                            l1[1][0] = intersection_x
                    # La ligne 2 est horizontale et c'est elle qu'on veut couper.
                    if l2[0][1] == l2[1][1]:
                        if len([p for p in points2 if p[0] == l2[0][0]]) == 0:
                            l2[0][0] = intersection_x
                        else:
                            l2[1][0] = intersection_x

        # On remet les listes de tableaux en listes de tuples.
        return [((l[0][0], l[0][1]), (l[1][0], l[1][1])) for l in lines1_2], \
               [((l[0][0], l[0][1]), (l[1][0], l[1][1])) for l in lines2_2]

    def _undistort_points(self, points):
        if len(points) == 0:
            return []
        # Convert the point list to the right format.
        points = np.asarray(points, dtype=float)
        points = points.reshape((points.shape[0], 1, points.shape[1]))
        # Undistort the points.
        points = cv2.undistortPoints(points, self.cameraMatrix, self.distCoeffs, P=self.cameraMatrix)
        # Create a new list with integer points.
        points2 = []
        for p in points:
            for p2 in p:
                points2.append((int(round(p2[0])), int(round(p2[1]))))
        return points2

    def _apply_perspective(self, points, matrix):
        if len(points) == 0:
            return []
        # Convert the point list to the right format.
        points = np.asarray(points, dtype=float)
        points = points.reshape((points.shape[0], 1, points.shape[1]))
        # Apply the perspective
        points = cv2.perspectiveTransform(points, matrix)
        # Create a new list with integer points.
        points2 = []
        for p in points:
            for p2 in p:
                points2.append((int(round(p2[0])), int(round(p2[1]))))
        return points2

    def _image_callback(self, msg):
        self.last_image = msg

    def _filter_callback(self, event):
        if self.last_image is None:
            return

        # Convert to cv2.
        img = self.bridge.imgmsg_to_cv2(self.last_image, "passthrough")
        height, width, depth = img.shape
        if self.display_raw_image:
            cv2.imshow("Raw", img)

        # Remove pixels outside the ellipse.
        ellipse_mask = self._get_ellipse_mask(width, height)
        img = cv2.bitwise_and(img, img, mask=ellipse_mask)

        # Hide lidar with a black rectangle.
        cv2.rectangle(img,
                      (self.rectangle_left_x, self.rectangle_left_y),
                      (self.rectangle_right_x, self.rectangle_right_y),
                      (0, 0, 0,),
                      -1)
        if self.display_rectangle_image:
            cv2.imshow("Rectangle", img)

        # Threshold colors to find blue and red.
        hsv = cv2.cvtColor(img, cv2.COLOR_BGR2HSV)
        blue_mask = self._get_threshold_mask(hsv,
                                             np.array([self.blue_min_hue, self.blue_min_saturation, self.blue_min_value]),
                                             np.array([self.blue_max_hue, self.blue_max_saturation, self.blue_max_value]))
        red_mask = self._get_threshold_mask(hsv,
                                            np.array([self.red_min_hue, self.red_min_saturation, self.red_min_value]),
                                            np.array([self.red_max_hue, self.red_max_saturation, self.red_max_value]))
        if self.display_thresholded_image:
            display_mask = cv2.bitwise_or(blue_mask, red_mask)
            cv2.imshow("Thresholded", cv2.bitwise_and(img, img, mask=display_mask))

        # Get one point per colored blob.
        blue_points = self._get_points(blue_mask, 30)
        red_points = self._get_points(red_mask, 30)
        if self.display_points_image:
            points_img = img.copy()
            for p in blue_points + red_points:
                cv2.circle(points_img, p, 6, (255, 255, 255), -1)
            cv2.imshow('Points', points_img)

        # Undistort points
        blue_points = self._undistort_points(blue_points)
        red_points = self._undistort_points(red_points)
        if self.display_undistorted_image or self.display_perspective_image or self.display_lines_image:
            undistorted_image = cv2.undistort(img, self.cameraMatrix, self.distCoeffs, np.matrix([]), self.cameraMatrix)
            if self.display_undistorted_image:
                undistorted_image_points = undistorted_image.copy()
                for p in blue_points + red_points:
                    cv2.circle(undistorted_image_points, (int(p[0]), int(p[1])), 6, (255, 255, 255), -1)
                cv2.imshow("Undistorted", undistorted_image_points)

        # Perspective transformation
        perspective_matrix = self._get_perspective_matrix(width, height)
        blue_points = self._apply_perspective(blue_points, perspective_matrix)
        red_points = self._apply_perspective(red_points, perspective_matrix)
        if self.display_perspective_image or self.display_lines_image:
            perspective_image = cv2.warpPerspective(undistorted_image, perspective_matrix, (width, height))
            for p in blue_points + red_points:
                cv2.circle(perspective_image, (int(p[0]), int(p[1])), 6, (255, 255, 255), -1)
            if self.display_perspective_image:
                cv2.imshow("Perspective", perspective_image)

        # Calculate the lines to block the robot.
        blue_lines = self._get_lines(blue_points, self.line_stripe_width)
        red_lines = self._get_lines(red_points, self.line_stripe_width, False)
        blue_lines, red_lines = self._filter_lines(blue_lines, red_lines, blue_points, red_points)

        if self.display_lines_image:
            for l in blue_lines:
                cv2.line(perspective_image, l[0], l[1], (255, 0, 0), 1)
            for l in red_lines:
                cv2.line(perspective_image, l[0], l[1], (0, 0, 255), 1)
            cv2.imshow("Lines", perspective_image)

        cv2.waitKey(1)

FlagFilter()

