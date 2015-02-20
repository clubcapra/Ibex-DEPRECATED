#! /usr/bin/env python

import roslib; roslib.load_manifest('capra_ai')
import rospy
from sensor_msgs.msg import LaserScan
import time
import math
from geometry_msgs.msg import *
import numpy as np
from PIL import Image, ImageDraw
from shapely.geometry import Polygon
from shapely import affinity
import cv2
from multiprocessing import Pool, cpu_count, Value
import random
import tf

theta = 0
map = None
map_size = 261
square_size = 130
max_dist = map_size / 2
angle_found = None
gps_angle = None
last_gps_pose = None

SPEED = 0.8
#DEFAULT_PRIORITY_ANGLES = [-20, -10, -30, -40, -50, 0, 10, 20, 30, -60, 40, 50, -70, 60, 70, -80, 80, -90, 90]
DEFAULT_PRIORITY_ANGLES = [0, -10, -20, 10, 20, -30, -40, 30, 40, -50, 0, -60, 50, -70, 60, 70, -80, 80, -90, 90]
angle = -20


def rf_callback(data):
    global map
    global map_size
    global max_dist
    ranges = data.ranges
    m = np.zeros((map_size, map_size))
    o = -90.0
    for i in xrange(90, 451):
        if ranges[i] > 0:
            if ranges[i] < 3:
                if o == 0:
                    x = 0
                    y = ranges[i] * 100
                else:
                    s = o/abs(o)
                    angle = math.radians((90-abs(o)) * s)
                    x = round(ranges[i] * math.cos(angle) * s * 100)
                    y = round(ranges[i] * math.sin(angle) * s * 100)

                if abs(x) < map_size / 2 and map_size > y > 0:
                    m[map_size - y - 1][map_size - (x + map_size / 2) - 1] = 1
        o += 0.5
    map = m


def get_mask(polygon):
    global map_size
    img = Image.new('L', (map_size, map_size), 0)
    ImageDraw.Draw(img).polygon(polygon, outline=255, fill=255)
    mask = np.array(img)   
    
    return mask


def apply_mask(map, mask):
    global map_size
    m = np.zeros((map_size, map_size))
    for i in range(map_size):
        for j in range(map_size):
            if mask[i, j]:
                m[i, j] = map[i, j]
    return m

def show_matrix(mat, name):
    im = np.asarray(mat)
    cv2.imshow(name, im)
    cv2.waitKey(10)


def init_proc(args):
    global angle_found
    angle_found = args


def check_angle(args):
    global angle_found
    if angle_found.value == 1:
        return -1
    angle = args[0]
    map = args[1]
    rect = args[2]

    s = affinity.rotate(rect, -(angle+90), origin=(int(map_size/2), map_size - 1))
    polygon = [(int(math.ceil(i)), int(math.ceil(j))) for i,j in list(s.exterior.coords)]

    mask = get_mask(polygon)
    m = apply_mask(map, mask)
    count = np.sum(m)
    if count == 0:
        angle_found.value = 1
        return angle
    else:
        return -1


def find_safe_angle(map, priority):
    global map_size
    global square_size
    global angle_found
    x1 = int(map_size/2) + 1
    y1 = map_size - square_size / 2 - 1
    x2 = x1 + square_size
    y2 = map_size + square_size/2 -1
    rect = Polygon(((x1, y1), (x1, y2), (x2, y2), (x2, y1)))

    tasks = list()

    # Multiprocessing parce que c'est vraiment pas optimise(<- accent aigu ici)
    for angle in priority:
        tasks.append((angle, map, rect))

    angles = pool.map(check_angle, tasks)
    b = angles[:]
    angles = sorted([a for a in angles if a != -1])
    angle_found.value = 0

    if len(angles) > 0:
        return angles[0]
    else:
        return 0

def gps_callback(data):
    print data
    global gps_angle
    global last_gps_pose
    q = data.orientation
    r, p, y = tf.transformations.euler_from_quaternion((q.x, q.y, q.z, q.w))
    gps_angle = math.degrees(y)
    print gps_angle
    last_gps_pose = time.time()

rospy.init_node('yolo_ai')
rospy.Subscriber("/base_scan", LaserScan, rf_callback)
rospy.Subscriber("/gps/next_waypoint", Pose, gps_callback)
cmd_vel = rospy.Publisher('/smartmotor/cmd_vel', Twist)

angle_found = Value('i', 0)
pool = Pool(processes=cpu_count()/2, initializer=init_proc, initargs=(angle_found, ))

while not rospy.is_shutdown():
    if map is not None:
        priority = DEFAULT_PRIORITY_ANGLES[:]
        priority.remove(angle)

        priority.insert(random.randint(0, 4), angle)  # Ajout du dernier angle quelque part en haut de la liste
        if gps_angle:
            if -90 <= gps_angle <= 90:
                priority.insert(0, gps_angle)

        angle = find_safe_angle(map, priority)
        rad = math.radians(angle)

        angular = rad
        linear = 0
        if abs(angle) < 45:
            linear = math.cos(angular) * SPEED

        twist = Twist()
        twist.linear.x = linear
        twist.angular.z = -angular
        
        if last_gps_pose:
            if time.time() - last_gps_pose > 0.2:
                twist.linear.x = 0
        
        cmd_vel.publish(twist)

    time.sleep(0.06)  # Because why not

rospy.spin()
