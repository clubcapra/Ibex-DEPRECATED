#!/usr/bin/python

# http://clubcapra.com/wiki/index.php/Contr%C3%B4leur_d%27alimentation

import serial
import rospy

def debug():
    pass


class SerialCom:

    def __init__(self): 
        pass

    def connect(self, port, baudrate, readTimeout):

        try:
            self.port = serial.Serial(
                    port, \
                    baudrate, \
                    serial.EIGHTBITS, \
                    serial.PARITY_NONE, \
                    serial.STOPBITS_ONE, \
                    readTimeout)
        except serial.SerialException:
            rospy.logfatal("Unable to connect to port " + str(port))
            return False

        return True
        
    def write(self, data):
        rospy.logdebug( "serialcom: writing:'" + data + "'")
        #print self.port.isOpen();
        self.port.write(data)

    def read(self, size):
        reply = self.port.read(size)
        rospy.logdebug( "serialcom: read:'" + reply + "'")
        return reply

    def close(self):
        self.port.close()
    

def formatMessage(tableau):
    string = "" 
    for t in tableau:
        string = string + chr(t)
    return string
