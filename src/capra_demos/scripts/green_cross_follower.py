import roslib; roslib.load_manifest('capra_demos')
import rospy
import numpy as np
import cv2
import math
from sensor_msgs.msg import Image, LaserScan
from geometry_msgs.msg import Twist
import cv_bridge

laser = None
speed = 0.3
rotation_angle = math.radians(30)

def get_tshirt_mask(img):
    imgb = cv2.bilateralFilter(img, 9, 150, 150)
    hsv = cv2.cvtColor(imgb, cv2.COLOR_BGR2HSV)

    thresh = cv2.inRange(hsv, np.array((120, 0, 0)), np.array((255, 255, 255)))
    thresh2 = cv2.inRange(hsv, np.array((0, 0, 0)), np.array((30, 255, 255)))
    thresh = cv2.bitwise_or(thresh, thresh2)

    #thresh = cv2.erode(thresh, np.ones((5, 5), np.uint8), iterations=2)
    #thresh = cv2.dilate(thresh, np.ones((5, 5), np.uint8), iterations=3)
    contour, hier = cv2.findContours(thresh, cv2.RETR_CCOMP, cv2.CHAIN_APPROX_SIMPLE)
    for cnt in contour:
        cv2.drawContours(thresh,[cnt],0,255,-1)

    #thresh = cv2.erode(thresh, np.ones((5, 5), np.uint8), iterations=10)

    return thresh

def find_cross_mask(img):
    imgb = cv2.bilateralFilter(img, 9, 500, 500)
    hsv = cv2.cvtColor(imgb, cv2.COLOR_BGR2HSV)
    thresh = cv2.inRange(hsv, np.array((50, 0, 0)), np.array((85, 255, 255)))
    edges = cv2.Canny(imgb, 50, 50)

    cv2.imshow("img5", edges)
    return thresh

def find_cross_rectangle(img):
    mask = get_tshirt_mask(img)
    img = cv2.bitwise_and(img,img,mask = mask)
    cv2.imshow("ccc", img)
    thresh = find_cross_mask(img)
        
    contour, hier = cv2.findContours(thresh, cv2.RETR_CCOMP, cv2.CHAIN_APPROX_SIMPLE)

    biggest_area = 0
    rect = (0, 0, 0, 0)
    for cnt in contour:
        x, y, w, h = cv2.boundingRect(cnt)
        area = w * h

        if area > biggest_area:
            rect = (x, y, w, h)
            biggest_area = area
    return rect


def laser_callback(msg):
    global laser
    laser = msg

def image_callback(msg):
    global speed, rotation_angle, cmd_vel

    bridge = cv_bridge.CvBridge()
    img = bridge.imgmsg_to_cv2(msg, desired_encoding="passthrough")
    rect = find_cross_rectangle(img)
    
    cv2.rectangle(img, (rect[0],rect[1]), (rect[0]+rect[2], rect[1]+rect[3]), (255, 0, 0), 3)
    cv2.imshow("img", img)
    cv2.waitKey(10)

    height, width, depth = img.shape
    img_center = width / 2
    cross_center = (rect[0] + rect[2] / 2)
    threshold = 50

    vel = Twist()

    if rect[0] != 0 and rect[2] * rect[3] > 300:
        angle = 0

        if cross_center > img_center + threshold:
            angle = -rotation_angle
        elif cross_center < img_center - threshold:
            angle = rotation_angle

        if rect[2] < 170:
            vel.linear.x = speed * math.cos(angle)
            vel.angular.z = speed * math.sin(angle)
        else:
            if angle != 0:
                vel.angular.z = speed * abs(angle)/angle

    print rect
    print vel
    cmd_vel.publish(vel)



rospy.init_node('green_cross_follower')
rospy.Subscriber('/capra_camera/image_uncompressed', Image, image_callback)
rospy.Subscriber('/scan', LaserScan, laser_callback)
cmd_vel = rospy.Publisher('/cmd_vel', Twist, queue_size=4)

rospy.spin()
cv2.destroyAllWindows()

