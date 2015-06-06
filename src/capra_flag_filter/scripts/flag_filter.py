import roslib
roslib.load_manifest('capra_camera')
import rospy
from sensor_msgs.msg import Image
import cv2
import numpy as np
import math
from cv_bridge import CvBridge, CvBridgeError


class FlagFilter:
    last_image = None
    perspective_matrix = None
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

    def __init__(self):
        rospy.init_node('capra_flag_filter')

        cv2.namedWindow('Raw', cv2.WINDOW_NORMAL)
        cv2.namedWindow('Thresholded', cv2.WINDOW_NORMAL)
        cv2.namedWindow('Points', cv2.WINDOW_NORMAL)
        cv2.namedWindow('Undistorted', cv2.WINDOW_NORMAL)
        cv2.namedWindow('Perspective', cv2.WINDOW_NORMAL)
        cv2.namedWindow('Lines', cv2.WINDOW_NORMAL)

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

    def _display_raw_image(self):
        return True

    def _display_thresholded_image(self):
        return True

    def _display_points_image(self):
        return True

    def _display_undistorted_image(self):
        return True

    def _display_perspective_image(self):
        return True

    def _display_lines_image(self):
        return True

    def _get_ellipse_mask(self, width, height):
        if self.ellipse_mask is None:
            self.ellipse_mask = np.zeros((height, width, 1), dtype=np.uint8)
            cv2.ellipse(self.ellipse_mask, (width/2 - 20, 370), (350, 320), 0, 360, 180, (255,), -1)
        return self.ellipse_mask

    def _get_perspective_matrix(self, width, height):
        if self.perspective_matrix is None:
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

    def _get_lines(self, points, max_dist_x, max_dist_y, left=True):
        lines = []
        for p in points:
            if left:
                lines.append(((p[0]-300, p[1]), p))
            else:
                lines.append((p, (p[0]+300, p[1])))

            for p2 in points:
                if p != p2:
                    if abs(p2[0] - p[0]) < max_dist_x and abs(p2[1] - p[1]) < max_dist_y:
                        lines.append((p, p2))
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
        if self._display_raw_image():
            cv2.imshow("Raw", img)

        # Remove pixels outside the ellipse.
        ellipse_mask = self._get_ellipse_mask(width, height)
        img = cv2.bitwise_and(img, img, mask=ellipse_mask)

        # Threshold colors to find blue and red.
        hsv = cv2.cvtColor(img, cv2.COLOR_BGR2HSV)
        blue_mask = self._get_threshold_mask(hsv, np.array([115, 191, 141]), np.array([124, 255, 255]))
        red_mask = self._get_threshold_mask(hsv, np.array([142, 83, 0]), np.array([255, 255, 255]))
        if self._display_thresholded_image():
            display_mask = cv2.bitwise_or(blue_mask, red_mask)
            cv2.imshow("Thresholded", cv2.bitwise_and(img, img, mask=display_mask))

        # Get one point per colored blob.
        blue_points = self._get_points(blue_mask, 30)
        red_points = self._get_points(red_mask, 30)
        if self._display_points_image():
            points_img = img.copy()
            for p in blue_points + red_points:
                cv2.circle(points_img, p, 6, (255, 255, 255), -1)
            cv2.imshow('Points', points_img)

        # Undistort points
        blue_points = self._undistort_points(blue_points)
        red_points = self._undistort_points(red_points)
        if self._display_undistorted_image() or self._display_perspective_image() or self._display_lines_image():
            undistorted_image = cv2.undistort(img, self.cameraMatrix, self.distCoeffs, np.matrix([]), self.cameraMatrix)
            if self._display_undistorted_image():
                undistorted_image_points = undistorted_image.copy()
                for p in blue_points + red_points:
                    cv2.circle(undistorted_image_points, (int(p[0]), int(p[1])), 6, (255, 255, 255), -1)
                cv2.imshow("Undistorted", undistorted_image_points)

        # Perspective transformation
        perspective_matrix = self._get_perspective_matrix(width, height)
        blue_points = self._apply_perspective(blue_points, perspective_matrix)
        red_points = self._apply_perspective(red_points, perspective_matrix)
        if self._display_perspective_image() or self._display_lines_image():
            perspective_image = cv2.warpPerspective(undistorted_image, perspective_matrix, (width, height))
            for p in blue_points + red_points:
                cv2.circle(perspective_image, (int(p[0]), int(p[1])), 6, (255, 255, 255), -1)
            cv2.imshow("Perspective", perspective_image)

        # Calculate the lines to block the robot.
        blue_lines = self._get_lines(blue_points, 100, 300)
        red_lines = self._get_lines(red_points, 100, 300, False)
        if self._display_lines_image():
            for l in blue_lines:
                cv2.line(perspective_image, l[0], l[1], (255, 0, 0), 3)
            for l in red_lines:
                cv2.line(perspective_image, l[0], l[1], (0, 0, 255), 3)
            cv2.imshow("Lines", perspective_image)

        cv2.waitKey(1)

FlagFilter()

