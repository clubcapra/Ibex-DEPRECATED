from command import *

class OpenPort(Command):
    def __init__(self, type="RS2", channel=0, parity="N", baudrate=19200, stop_bits=1, start_bits=8, mode="C"):
        super(OpenPort, self).__init__() 
        self.type = type
        self.channel = channel
        self.parity = parity
        self.baudrate = baudrate
        self.stop_bits = stop_bits
        self.start_bits = start_bits
        self.mode = mode
        
    def __str__( self ):
        return "OCHN(%s,%i,%s,%i,%i,%i,%s)"%(self.type, self.channel, self.parity, self.baudrate, self.stop_bits, self.start_bits, self.mode)

