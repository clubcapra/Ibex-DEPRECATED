from command import *

class ResetEncoders(Command):
    def __init__(self):
        super(ResetEncoders, self).__init__() 
        
    def __str__( self ):
        return "O=0"


