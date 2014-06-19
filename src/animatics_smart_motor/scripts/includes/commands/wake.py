from command import *


class Wake(Command):
    def __init__(self):
        super(Wake, self).__init__()
        
    def __str__(self):
        return "WAKE"



