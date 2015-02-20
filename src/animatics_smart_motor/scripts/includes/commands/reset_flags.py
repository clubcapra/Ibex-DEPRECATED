from command import *


class ResetFlags(Command):
    def __init__(self):
        super(ResetFlags, self).__init__()
        
    def __str__(self):
        return "ZS"


