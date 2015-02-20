from command import *


class SetErrorLimit(Command):
    def __init__(self, limit):
        super(SetErrorLimit, self).__init__()
        self.limit = limit
        
    def __str__(self):
        return "EL=%i" % self.limit


