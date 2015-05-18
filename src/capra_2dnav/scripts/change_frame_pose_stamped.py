#!/usr/bin/env python
# license removed for brevity
import rospy
from nav_msgs.msg import Odometry
from geometry_msgs.msg import PoseStamped

class ChangeFramePoseStamped:

    def callback(self, data):
        data2 = data
        data2.header.frame_id = self.new_frame
        self.pub.publish(data2)

    def __init__(self):
        rospy.init_node('ChangeFramePoseStamped', anonymous=True)

        self.new_frame = rospy.get_param("~frame_id", "")
        in_topic = rospy.get_param("~in", "")
        out_topic = rospy.get_param("~out", "")
        self.pub = rospy.Publisher(out_topic, PoseStamped, queue_size=10)
        rospy.Subscriber(in_topic, PoseStamped, self.callback)

        rospy.spin()

if __name__ == '__main__':
    try:
        ChangeFramePoseStamped()
    except rospy.ROSInterruptException:
        pass