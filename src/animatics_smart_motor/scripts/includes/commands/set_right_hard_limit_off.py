from command import *


class SetRightHardLimitOff(Command):
    def __init__(self):
        super(SetRightHardLimitOff, self).__init__()
        
    def __str__(self):
        return "EIGN(3)"


