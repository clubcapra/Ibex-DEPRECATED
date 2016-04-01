#! /usr/bin/env python

from state_ai import StateAi
import rospy
from math import pi
from std_msgs.msg import Bool
import xml.etree.ElementTree as ET
import inflection
import inspect

def camel2snake(name):
    return inflection.underscore(name)


class StateAiLoader(StateAi):

    def __init__(self):
        super(StateAiLoader, self).__init__("state_ai_loader", log_level=rospy.DEBUG)

        self.state_file = rospy.get_param('~state_file')

        tree = ET.parse(self.state_file)
        self.root = tree.getroot()
        self.fn_map = {}
        self.validate_state_file()

        raise Exception()

    def validate_state_file(self):
        '''
        Validate that the state file respects the given spectification in hope
        to reduce the number of runtime exceptions
        '''
        assert len(self.root.findall('onStart')) == 1, 'There should be only one onStart tag per file'
        assert len(self.root.findall('onLastGoalReached')) == 1, 'There should only be one onLastGoalReached tag per file'
        goal_attrs = ['id', 'lat', 'lng']

        for goal in self.root.findall('goal'):
            for key in goal_attrs:
                assert goal.attrib.has_key(key), 'Goal must have id, lat and lng attributes'

        for action in self.root.findall('./*/*'):
            fn_name = camel2snake(action.tag)
            self.fn_map[action.tag] = fn_name

            assert hasattr(self, fn_name), 'StateAi does not offer the method ' + fn_name

            fn_desc = inspect.getargspec(getattr(self, fn_name))
            non_default_params = fn_desc.args[1:len(fn_desc.args) - len(fn_desc.defaults)]

            for param in non_default_params:
                assert action.attrib.has_key(param), 'Action %s should specify the non default argumment %s' % (action.tag, param)

    def on_start(self):
        pass

    def on_goal_changed(self, goal_msg):
        pass

    def on_last_goal_reached(self, msg):
        pass


if __name__ == "__main__":
    try:
        a = StateAiLoader()
    except rospy.ROSInterruptException:
        pass
