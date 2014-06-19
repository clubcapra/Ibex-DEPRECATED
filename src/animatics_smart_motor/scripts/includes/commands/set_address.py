from command import *


class SetAddress(Command):
    def __init__(self, addr):
        super(SetAddress, self).__init__()
        self.addr = addr
        
    def __str__(self):
        return "SADDR%i" % self.addr


