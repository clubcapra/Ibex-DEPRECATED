#! /usr/bin/env python

from state_ai import StateAi
import rospy
from math import pi
from math import radians
from std_msgs.msg import Bool
import xml.etree.ElementTree as ET
import inflection
import inspect
from capra_ai.srv import AddGoal
from capra_ai.msg import GoalWithPriority
from sensor_msgs.msg import NavSatFix
from capra_gps.srv import AddLatlongGoal

def camel2snake(name):
    return inflection.underscore(name)


def apply_type(value):
    '''
    Attemps to convert a string into its proper scalar type
    '''
    try:
        return int(value)
    except:
        pass

    try:
        return float(value)
    except:
        pass

    return value


class StateAiLoader(StateAi):

    def __init__(self):
        super(StateAiLoader, self).__init__("state_ai_loader", log_level=rospy.DEBUG, start=False)
        rospy.wait_for_service('/move_base/make_plan')
        rospy.wait_for_service('/octomap_server/reset')
        rospy.sleep(2.0)  # wait for move_base to be ready
        print "---------------------------------------------------------------------------"
        self.state_file = rospy.get_param('~state_file')
        rospy.loginfo("Parsing {} run configuration file".format(self.state_file))
        self.root = ET.parse(self.state_file).getroot()
        self.fn_map = {}
        self.last_goal = None
        self.latlong_service = None
        self.current_goal_index = 0
        self._validate_state_file()
        self._publish_goals()

        self.on_start()

        rospy.spin()

    def clear_octomap(self, center_x, center_y, width, height):
        super(StateAiLoader, self).clear_octomap([center_x, center_y], width, height)

    def on_start(self):
        for action in self.root.findall('./onStart/*'):
            self._invoke_action(action.tag, action.attrib)

    def on_goal_changed(self, goal_msg):
        self.current_goal_index += 1
        for action in self.root.findall('./goal[{}]/*'.format(self.current_goal_index)):
            self._invoke_action(action.tag, action.attrib)

    def on_last_goal_reached(self, msg):
        for action in self.root.findall('./onLastGoalReached/*'):
            self._invoke_action(action.tag, action.attrib)

    def _validate_state_file(self):
        assert len(self.root.findall('onStart')) == 1, 'There should be only one onStart tag per file'
        assert len(self.root.findall('onLastGoalReached')) == 1, 'There should only be one onLastGoalReached tag per file'

        goal_attrs = ['priority', 'x', 'y', 'type']

        for goal in self.root.findall('goal'):
            for key in goal_attrs:
                assert goal.attrib.has_key(key), 'Goal tag must have priority, x and y attributes'

        for action in self.root.findall('./*/*'):
            fn_name = self.fn_map.setdefault(action.tag, camel2snake(action.tag))

            assert hasattr(self, fn_name), 'StateAi does not offer the method "%s"' % fn_name

            # find list of required arguments for the action
            fn_desc = inspect.getargspec(getattr(self, fn_name))
            non_default_params = fn_desc.args[1:(len(fn_desc.args) - len(fn_desc.defaults or []))]

            for param in non_default_params:
                assert action.attrib.has_key(param), 'Action "%s" should specify the non default argument "%s"' % (action.tag, param)


    def _publish_goals(self):

        for goal in self.root.findall('./goal'):
            rospy.loginfo("pusblishing goals")
            if goal.attrib['type'] == 'gps':
                x, y = self.convert_to_pose(goal.attrib['x'], goal.attrib['y'])
                self.send_goal(x, y, int(goal.attrib['priority']))
            else:
                self.send_goal(float(goal.attrib['x']), float(goal.attrib['y']), int(goal.attrib['priority']))

    def convert_to_pose(self, x, y):
        if not self.latlong_service:
            rospy.loginfo("Waiting for AddLatLongGoal service...")
            rospy.wait_for_service('/latlong_goal_node/AddLatlongGoal')
            rospy.loginfo("AddLatLongGoal service responded")
            self.latlong_service = rospy.ServiceProxy('/latlong_goal_node/AddLatlongGoal', AddLatlongGoal)
        # create NavSatFix msg
        nav_msg = NavSatFix()
        nav_msg.header.stamp = rospy.get_rostime()
        nav_msg.header.frame_id = 'odom'
        # x is longitude, y is latitude
        nav_msg.longitude = float(x)
        nav_msg.latitude = float(y)
        # convert using /latlong_goal_node/AddLatLongGoal service
        # returns PoseStamped
        response = self.latlong_service(nav_msg)
        rospy.loginfo("Converted NavSatFix to PoseStamped -> (%f, %f)" % (response.goal_xy.pose.position.x,
                      response.goal_xy.pose.position.y))
        return response.goal_xy.pose.position.x, response.goal_xy.pose.position.y

    def generate_circle(self, radius, start_deg, end_deg, step_deg, duration):
        super(StateAiLoader, self).generate_circle(radius, radians(start_deg), radians(end_deg), radians(step_deg), duration)

    def _invoke_action(self, action, params):
        typed_params = {}

        for key in params:
            typed_params[key] = apply_type(params[key])

        getattr(self, self.fn_map[action])(**typed_params)


if __name__ == "__main__":
    try:
        a = StateAiLoader()
    except rospy.ROSInterruptException:
        pass
