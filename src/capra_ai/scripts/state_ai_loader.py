#! /usr/bin/env python

from state_ai import StateAi
import rospy
from math import pi
from std_msgs.msg import Bool
import xml.etree.ElementTree as ET
import inflection
import inspect
from capra_ai.srv import AddGoal
from capra_ai.msg import GoalWithPriority


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

        self.state_file = rospy.get_param('~state_file')
        self.root = ET.parse(self.state_file).getroot()
        self.fn_map = {}
        self.last_goal = None

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
        for action in self.root.findall('./goal[@priority="%s"]/*' % goal_msg.priority):
            self._invoke_action(action.tag, action.attrib)

    def on_last_goal_reached(self, msg):
        for action in self.root.findall('./onLastGoalReached/*'):
            self._invoke_action(action.tag, action.attrib)

    def _validate_state_file(self):
        assert len(self.root.findall('onStart')) == 1, 'There should be only one onStart tag per file'
        assert len(self.root.findall('onLastGoalReached')) == 1, 'There should only be one onLastGoalReached tag per file'

        goal_attrs = ['priority', 'x', 'y']

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
            self.send_goal(float(goal.attrib['x']), float(goal.attrib['y']), int(goal.attrib['priority']))


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
