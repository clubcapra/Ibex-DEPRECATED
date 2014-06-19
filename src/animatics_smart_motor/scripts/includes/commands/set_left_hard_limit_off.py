from command import *


class SetLeftHardLimitOff(Command):
    def __init__(self):
        super(SetLeftHardLimitOff, self).__init__()
        
    def __str__(self):
        return "EIGN(2)"


