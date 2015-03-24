#!/usr/bin/env python

import roslib
roslib.load_manifest('goal_manager')
import rospy
from geometry_msgs.msg import PoseStamped
from actionlib_msgs.msg import GoalStatusArray, GoalStatus


# PoseStamped.header.stamp = GoalStatusArray.status_list[].goal_id
class GoalManager():

    class Goal():
        def __init__(self, goal):
            self.goal = goal
            self.reached = False

    def __init__(self):
        self.goals = {}
        self.current = None
        self.publisher = rospy.Publisher("/move_base_simple/goal", PoseStamped, queue_size=10)
        rospy.Subscriber("~waypoint", PoseStamped, waypoint_received)
        rospy.Subscriber("/move_base/status", GoalStatusArray, status_updated)
        self.loop()

    def loop(self):
        rate = rospy.Rate(10)
        while not rospy.is_shutdown():
            if self.goals:
                if self.current.reached:
                    currentid = self.current.goal.header.stamp
                    self.removegoal(currentid)
                    nextgoal = self.goals.popitem()
                    self.publisher.publish(nextgoal.goal)
            rate.sleep()

    def addwaypoint(self, msg):
        goal_id = msg.header.stamp
        goal = GoalManager.Goal(msg)
        self.goals[goal_id] = goal

    def getgoal(self, goal_id):
        return self.goals[goal_id]

    def updategoal(self, goal_id, goal):
        self.goals[goal_id] = goal

    def removegoal(self, goal_id):
        if goal_id in self.goals:
            del self.goals[goal_id]


def waypoint_received(msg):
    global goalie
    goalie.addwaypoint(msg)


def status_updated(msg):
    global goalie
    for goalstatus in msg.status_list:
        current = goalie.getgoal(goalstatus.goal_id)
        status = goalstatus.status
        if status == GoalStatus.PENDING:
            # The goal has yet to be processed by the action server
            pass
        elif status == GoalStatus.ACTIVE:
            # The goal is currently being processed by the action server
            current.reached = False
        elif status == GoalStatus.PREEMPTED:
            # The goal received a cancel request after it started executing and has since completed its execution
            pass  # ???
        elif status == GoalStatus.SUCCEEDED:
            current.reached = True
        elif status == GoalStatus.ABORTED:  # aborted during execution due to some failure
            current.reached = True  # setting to true updates to a new goal
        elif status == GoalStatus.REJECTED:
            # The goal was rejected by the action server without being processed; the goal was unattainable/invalid
            goalie.removegoal(goalstatus.goal_id)  # goal wasn't executed yet?
        elif status == GoalStatus.PREEMPTING:
            pass  # wait for preempted status
        elif status == GoalStatus.RECALLING:
            pass  # wait for recalled status
        elif status == GoalStatus.RECALLED:
            # The goal received a cancel request before it started executing and was successfully cancelled
            goalie.removegoal(goalstatus.goal_id)  # goal not executed yet, so just remove it
        elif status == GoalStatus.LOST:
            # An action client can determine that a goal is LOST. This should not be sent by an action server
            pass  # wtf do I do with this
        else:
            rospy.logwarn("GoalStatus enumeration has been changed, please see ROS documentation")
        goalie.updategoal(goalstatus.goal_id, current)


if __name__ == '__main__':
    rospy.init_node('goal_manager')
    try:
        global goalie
        goalie = GoalManager()
    except rospy.ROSInterruptException: pass