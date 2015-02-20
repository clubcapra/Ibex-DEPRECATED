from command import *
from ..utils.motor_utils import MotorUtils


class SetAbsolutePosition(Command):
    def __init__(self, angle):
        super(SetAbsolutePosition, self).__init__()
        self.angle = angle
        
    def __str__(self):
        return "PT=%i" % int(MotorUtils.degree_to_counts(self.angle))


