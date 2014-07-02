from command import *
from set_left_hard_limit_off import SetLeftHardLimitOff
from set_right_hard_limit_off import SetRightHardLimitOff
from set_soft_limit import SetSoftLimit
from set_error_limit import SetErrorLimit


class DisableLimits(Command):
    def __init__(self):
        super(DisableLimits, self).__init__()
        
    def __str__(self):
        commands = [SetLeftHardLimitOff(),
                    SetRightHardLimitOff(),
                    SetSoftLimit(False),
                    SetErrorLimit(32000)]
        return "\n".join([str(c) for c in commands])

