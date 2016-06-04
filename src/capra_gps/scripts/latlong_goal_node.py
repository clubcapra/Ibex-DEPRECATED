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
    global sub_convert
    global data_received

    if not data_received:
        pub_convert.publish(req)
        data_received = True

        sub_convert.unregister()
        rospy.loginfo("Initial coordinates sent, now starting AddLatlongGoal Service")

        start_latlong_service()


def start_latlong_service():
    service = rospy.Service("~AddLatlongGoal", AddLatlongGoal, handle_add_latlong_goal)
    rospy.Subscriber("~convert_xy", Odometry, handle_xy_goal)

    global pub_goal
    pub_goal = rospy.Publisher("~goal_xy", PoseStamped, queue_size=10)


class LatlongGoalTransformer:
    def __init__(self):
        rospy.init_node('latlong_goal_node')

        global data_received
        data_received = False

        # send first (real) coordinates to converter.
        global pub_convert
        pub_convert = rospy.Publisher("~convert_latlong", NavSatFix, queue_size=100)

        global sub_convert
        sub_convert = rospy.Subscriber("/gps/fix", NavSatFix, handle_fix)

        rospy.spin()


if __name__ == "__main__":
    try:
        LatlongGoalTransformer()
    except rospy.ROSInterruptException:
        pass
