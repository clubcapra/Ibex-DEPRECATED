from command import *


class SetSoftLimit(Command):
    def __init__(self, enable):
        super(SetSoftLimit, self).__init__()
        self.enable = enable
        
    def __str__(self):
        if self.enable:
            return "SLE"
        else:
            return "SLD"


