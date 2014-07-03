from command import *


class SetBaudrate(Command):
    def __init__(self, baudrate):
        super(SetBaudrate, self).__init__()
        self.baudrate = baudrate
        
    def __str__(self):
        return "BAUD%i" % self.baudrate


