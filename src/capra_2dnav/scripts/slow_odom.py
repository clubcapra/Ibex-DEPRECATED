#!/usr/bin/env python
# license removed for brevity
import rospy
from nav_msgs.msg import Odometry
import tf

class SlowOdom:

    start = False
    def callback(self, data):
        self.last_pose = data.pose.pose
        self.start = True

    def __init__(self):
        rospy.init_node('SlowOdom', anonymous=True)

        self.tf_listener = tf.TransformListener()
        self.br = tf.TransformBroadcaster()

        rospy.Subscriber("/odom", Odometry, self.callback)
        r = rospy.Rate(20)

        slowdown_factor = rospy.get_param("~slowdown_factor", 1.0)

        while not rospy.is_shutdown():
            if self.start:
                trans = (self.last_pose.position.x/slowdown_factor, self.last_pose.position.y/slowdown_factor, self.last_pose.position.z)
                rotQ = (self.last_pose.orientation.x, self.last_pose.orientation.y, self.last_pose.orientation.z, self.last_pose.orientation.w)
                self.br.sendTransform(trans, rotQ, rospy.Time.now(), "/base_footprint", "/odom")

            r.sleep()

if __name__ == '__main__':
    try:
        SlowOdom()
    except rospy.ROSInterruptException:
        pass