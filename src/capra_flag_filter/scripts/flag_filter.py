import roslib
roslib.load_manifest('capra_camera')
import rospy
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
    display_thresholded_image = False
    display_points_image = False
    display_undistorted_image = False
    display_perspective_image = False
    display_lines_image = False

    def __init__(self):
        rospy.init_node('capra_flag_filter')
        self.parameter_server = Server(FlagFilterConfig, self._parameter_callback)

        self.ellipse_mask = None
        self.distCoeffs = np.array([-0.34, 0.085, 0, 0, -0.007])
        self.cameraMatrix = np.matrix([[630.79035702238025/2, 0, 645.50000000000000/2],
                                       [0, 630.79035702238025/2, 366.50000000000000/2],
                                       [0,                  0,                  1]])
        self.bridge = CvBridge()
        rospy.Subscriber("/image_raw_throttle", Image, self._image_callback)
        rospy.Timer(rospy.Duration(0.1), self._filter_callback)
        rospy.spin()
        cv2.destroyAllWindows()

    def _parameter_callback(self, config, level):
        for parameter, value in config.items():
            if hasattr(self, parameter):
                if getattr(self, parameter) != value:
                    rospy.loginfo("Updating %s: %s" % (parameter, str(value)))
                    setattr(self, parameter, value)
                    if parameter.startswith("perspective_"):
                        self.update_perspective_matrix = True
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
        if self.display_lines_image:
            for l in blue_lines:
                cv2.line(perspective_image, l[0], l[1], (255, 0, 0), 1)
            for l in red_lines:
                cv2.line(perspective_image, l[0], l[1], (0, 0, 255), 1)
            cv2.imshow("Lines", perspective_image)

        cv2.waitKey(1)

FlagFilter()

