from command import *


class SetMode(Command):
    TORQUE = "MT"
    POSITION = "MP"
    VELOCITY = "MV"

    def __init__(self, mode):
        super(SetMode, self).__init__()
        self.mode = mode
        
    def __str__(self):
        return self.mode


