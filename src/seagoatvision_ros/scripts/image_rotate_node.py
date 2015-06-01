
import rospy
from sensor_msgs.msg import Image, PointCloud2
import sensor_msgs.point_cloud2 as pc2
from cv_bridge import CvBridge
import numpy as np
import cv2
import cv2.cv as cv
from math import sin, cos

bridge = CvBridge()

# Source: http://jepsonsblog.blogspot.ca/2012/11/rotation-in-3d-using-opencvs.html
def transformImage(input, rx, ry, rz, dx, dy, dz, f):
    rx = (rx - 90.0) * cv.CV_PI/180.0
    ry = (ry - 90.0) * cv.CV_PI/180.0
    rz = (rz - 90.0) * cv.CV_PI/180.0

    # get width and height for ease of use in matrices
    h = float(input.shape[0])
    w = float(input.shape[1])

    # Projection 2D -> 3D matrix
    A1 = np.array([[1.0, 0, -w/2.0],
                   [0, 1.0, -h/2.0],
                   [0, 0,    0],
                   [0, 0,    1.0]])

    # Rotation matrices around the X, Y, and Z axis
    RX = np.array([[1.0,       0,        0, 0],
                   [0, cos(rx), -sin(rx), 0],
                   [0, sin(rx),  cos(rx), 0],
                   [0,       0,        0, 1.0]])

    RY = np.array([[cos(ry), 0, -sin(ry), 0],
                   [      0, 1.0,        0, 0],
                   [sin(ry), 0,  cos(ry), 0],
                   [      0, 0,        0, 1.0]])

    RZ = np.array([[cos(rz), -sin(rz), 0, 0],
                   [sin(rz),  cos(rz), 0, 0],
                   [      0,        0, 1.0, 0],
                   [      0,        0, 0, 1.0]])

    # Composed rotation matrix with (RX, RY, RZ)
    R = RX * RY * RZ

    # Translation matrix
    T = np.array([[1.0, 0, 0, dx],
                  [0, 1.0, 0, dy],
                  [0, 0, 1.0, dz],
                  [0, 0, 0, 1.0]])

    # 3D -> 2D matrix
    A2 = np.array([[f, 0, w/2.0, 0],
                    [0, f, h/2.0, 0],
                    [0, 0,   1.0, 0]])

    # Final transformation matrix
    # trans = A2 * (T * (R * A1))
    trans = np.dot(A2, np.dot(T, np.dot(R, A1)))

    rz = 0.5
    RZ2 = np.array([[cos(rz), -sin(rz), 0],
                    [sin(rz),  cos(rz), 0],
                    [      0,        0, 1.0]])


    # Translation matrix
    T2 = np.array([[1.0, 0, 500],
                   [0, 1.0, 500],
                   [0, 0,  1.0]])

    T3 = np.array([[1.0, 0, -w/2],
                   [0, 1.0, -h/2],
                   [0, 0,  1.0]])

   # t = np.dot(T2, np.dot(RZ2, T3))
    t = np.dot(A2, T)
    print t

    # Apply matrix transformation
    rotated = input
    cv2.warpPerspective(input, t, (input.shape[1], input.shape[0]), rotated, cv.CV_INTER_CUBIC | cv.CV_WARP_INVERSE_MAP)

    return rotated

def handle_image(req):

    img = bridge.imgmsg_to_cv2(req, desired_encoding="passthrough")
    img = cv2.cvtColor(img, cv.CV_BGR2RGB)

    img = transformImage(img, 0, 0, 0, 0, 0, 0, 1)

    msg = bridge.cv2_to_imgmsg(img, encoding="passthrough")

    global pub
    pub.publish(msg)



def handle_tf():
    pass


class ImageRotate:

    def __init__(self):
        rospy.init_node('image_rotate_node')

        rospy.Subscriber("/image_raw", Image, handle_image)
       # rospy.Subscriber("/tf", Image, handle_tf)

        global pub
        pub = rospy.Publisher("/image_rotated", Image, queue_size=10)

        rospy.spin()

if __name__ == "__main__":
    try:
        node = ImageRotate()
    except rospy.ROSInterruptException:
        pass






