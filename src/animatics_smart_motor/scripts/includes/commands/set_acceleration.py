from command import *
from ..utils.motor_utils import MotorUtils


class SetAcceleration(Command):
    def __init__(self, accel):
        super(SetAcceleration, self).__init__()
        self.accel = accel
        
    def __str__(self):
        return "AT=%i" % MotorUtils.revs_to_counts(self.accel)


