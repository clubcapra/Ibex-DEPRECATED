import abc
import roslib; roslib.load_manifest('capra_ai')
import rospy
from sensor_msgs.msg import LaserScan
from geometry_msgs.msg import Twist


class BaseAI(object):
    _scan = None
    _rate = None

    def __init__(self, name):
        rospy.init_node(name)

        self.cmd_vel = rospy.Publisher('/cmd_vel', Twist, queue_size=4)
        rospy.Subscriber('/scan', LaserScan, self._rf_callback)

        self.set_frequency(self.get_param("~rate", 10))


    def set_frequency(self, freq):
        self._rate = rospy.Rate(freq)

    def get_scan(self):
        return self._scan

    def run(self):
        while not rospy.is_shutdown() and self._scan is None:
            rospy.sleep(0.1)

        while not rospy.is_shutdown():
            self.loop()
            self._rate.sleep()

    def get_param(self, name, default_value):
        return rospy.get_param(name, default_value)

    def _rf_callback(self, msg):
        self._scan = msg

    def set_velocity(self, linear, angular):
        msg = Twist()
        msg.linear.x = linear
        msg.angular.z = angular
        self.cmd_vel.publish(msg)

    @abc.abstractmethod
    def loop(self):
        return None