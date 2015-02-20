from command import *

class ReportTemperature(Command):
    def __init__(self):
        super(ReportTemperature, self).__init__() 
        
    def __str__( self ):
        return "Rt"


