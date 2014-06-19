from command import *


class SetTorque(Command):
    def __init__(self, percent):
        super(SetTorque, self).__init__()

        if percent > 100:
            percent = 100
        elif percent < -100:
            percent = -100

        self.percent = percent
        
    def __str__(self):
        return "T=%i" % int(self.percent/100 * 1023)



