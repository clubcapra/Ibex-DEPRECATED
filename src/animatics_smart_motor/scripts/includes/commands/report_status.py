from command import *

class ReportStatus(Command):
    def __init__(self):
        super(ReportStatus, self).__init__() 
        
    def __str__( self ):
        return "RW"


