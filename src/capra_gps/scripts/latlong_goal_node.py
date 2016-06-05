#!/usr/bin/env python
import rospy
from geometry_msgs.msg import PoseStamped
from nav_msgs.msg import Odometry
from sensor_msgs.msg import NavSatFix
from capra_gps.srv import AddLatlongGoal

pub_goal = None
pub_convert = None
sub_convert = None

p = []
def handle_xy_goal(req):
    new_pos = PoseStamped()
    new_pos.header = req.header
    new_pos.pose = req.pose.pose
    rospy.loginfo("GPS goal converted to xy: " + str(new_pos.pose.position.x) + ", " + str(new_pos.pose.position.y) + ". Publishing..")
    global pub_goal
    pub_goal.publish(new_pos)
    global p
    p.append(new_pos)


def handle_add_latlong_goal(req):
    rospy.loginfo("Received GPS goal: " + str(req.goal_latlong.longitude) + ", " + str(req.goal_latlong.latitude))
    pub_convert.publish(req.goal_latlong)
    global p
    start_size = len(p)
    while len(p) == start_size:
        rospy.sleep(0.01)
    answer = p[start_size]
    return answer

# Subscribe to gps fix and forward to the converter at the beginning
def handle_fix(req):
    global pub_convert
    pub_convert.publish(req)

class LatlongGoalTransformer:

    def __init__(self):
        rospy.init_node('latlong_goal_node')

        # send first (real) coordinates to converter.
        global pub_convert
        pub_convert = rospy.Publisher("~convert_latlong", NavSatFix, queue_size=100)

        sub_convert = rospy.Subscriber("/gps/fix", NavSatFix, handle_fix)
        rospy.sleep(10)
        sub_convert.unregister()
        rospy.sleep(0.5)
        rospy.loginfo("Initial coordinates sent, now starting AddLatlongGoal Service")

        #stop listening to real gps and listen to topic to receive converted goals
        service = rospy.Service("~AddLatlongGoal", AddLatlongGoal, handle_add_latlong_goal)
        rospy.Subscriber("~convert_xy", Odometry, handle_xy_goal)

        global pub_goal
        pub_goal = rospy.Publisher("~goal_xy", PoseStamped, queue_size=10)

        rospy.spin()

if __name__ == "__main__":
    try:
        LatlongGoalTransformer()
    except rospy.ROSInterruptException:
        pass
