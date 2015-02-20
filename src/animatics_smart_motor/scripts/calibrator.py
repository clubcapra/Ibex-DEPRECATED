# ! /usr/bin/env python

__author__ = 'guillaumechevalier'

import time
import math
import numpy
import tf
import roslib
import rospy
from capra_msgs.srv import *
from geometry_msgs.msg import Twist
from thread import start_new_thread

from sensor_msgs.msg import Imu

roslib.load_manifest('capra_motors')

VERIFICATION_TIME = 3
CONFIGURATION_TIME = 3
WAIT_FOR_SERVICE_TIMEOUT = 5
ORIENTATION_THRESHOLD = 1.0

class SmartmotorCalibrator:
    def __init__(self):
        self.initial_imu_orientation = 0
        self.calibrated = False
        self.angularSpeed = 0.0
        self.start_time = 0
        self.currentRotation = 0
        self.imu_functional = False
        self.lastOrientation = 0
        rospy.init_node('smartmotor_calibrator', anonymous=True)

        try:
            start_acquisition = rospy.ServiceProxy('/imu3dmgx1/start_acquisition', StartAcquisition)()
            rospy.wait_for_service('/imu3dmgx1/start_acquisition', timeout=WAIT_FOR_SERVICE_TIMEOUT)
            resp1 = start_acquisition()
        except rospy.ServiceException as exc:
            print("Service did not process request: " + str(exc))
        self.subscriber = rospy.Subscriber('/imu_datum', Imu, self.verify_imu_callback)
        self.publisher = rospy.Publisher('/smartmotor/cmd_vel', Twist)


    def verify_imu_callback(self, msg):
        if not self.imu_functional:
            o = msg.orientation
            r, p, y = tf.transformations.euler_from_quaternion([o.x, o.y, o.z, o.w])
            self.currentRotation = y * 180 / math.pi

            print "rotation = " + self.rotation
            if (self.initial_imu_orientation == None):
                self.initial_imu_orientation = self.currentRotation
            elif (self.currentRotation - self.initial_imu_orientation > ORIENTATION_THRESHOLD) or (self.currentRotation - self.initial_imu_orientation < (ORIENTATION_THRESHOLD * (-1))):
                print "Le IMU n'est pas calibre"
                exit(0)


    def correctAngularSpeed(self, leftRightCorrection):
        self.lastOrientation = self.currentRotation
        if self.leftRightCorrection == "left":
            print "Correcting left angular velocity (0.05)"
            self.angularSpeed += 0.05
        elif leftRightCorrection == "right":
            print "Correcting right angular velocity (0.05)"
            self.angularSpeed -= 0.05

    def send_vel_commands(self):
        while not self.calibrated and not rospy.is_shutdown():
            t = Twist()
            t.linear.x = 0.3
            t.angular.z = self.angularSpeed
            self.publisher.publish(t)
            time.sleep(0.1)

    def calibrateSmartmotor(self):
        raw_input("Capra smartmotor calibreur v1... <enter>:")
        self.start_time = time.time()
        print "Verification de la calibration du Imu ("+str(VERIFICATION_TIME)+" secondes)..."

        while not rospy.is_shutdown():
            if time.time() > self.start_time + VERIFICATION_TIME:
                self.imu_functional = True
                raw_input("Le robot avancera pendant "+str(CONFIGURATION_TIME)+" secondes, ne pas rester devant...<enter>:")
                print "demarrage du test"
                self.lastOrientation = self.initial_imu_orientation
                start_new_thread(self.send_vel_commands, ())
                self.start_time = time.time()
                while self.imu_functional and not rospy.is_shutdown() and not self.calibrated:
                    if self.lastOrientation - self.currentRotation > 1.0:
                        self.correctAngularSpeed("left")
                    elif self.lastOrientation - self.currentRotation < -1.0:
                        self.correctAngularSpeed("right")
                    if time.time() > self.start_time + CONFIGURATION_TIME:
                        self.calibrated = True
                        print "Capra smartmotors : Vitesse angulaire ideale = "+str(self.angularSpeed)
                        exit(0)

if __name__ == '__main__':
    sc = SmartmotorCalibrator()
    sc.calibrateSmartmotor()
