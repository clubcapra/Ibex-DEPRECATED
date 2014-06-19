from command import *
from ..utils.motor_utils import MotorUtils

class Wait(Command):
    def __init__(self, time):
        super(Wait, self).__init__()
        self.time = time
        
    def __str__(self):
        return "WAIT=" + MotorUtils.sec_to_counts(self.time)



