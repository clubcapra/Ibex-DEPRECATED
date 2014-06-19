from command import *


class Sleep(Command):
    def __init__(self):
        super(Sleep, self).__init__()
        
    def __str__(self):
        return "SLEEP"



