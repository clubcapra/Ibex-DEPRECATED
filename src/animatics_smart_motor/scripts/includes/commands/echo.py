from command import *

class Echo(Command):
    def __init__(self, state):
        super(Echo, self).__init__() 
        self.state = state
        
    def __str__( self ):
        if self.state:
            return "ECHO"
        else:
            return "ECHO_OFF"

