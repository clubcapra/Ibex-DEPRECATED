import serial
from motor import Motor


class Swivel(Motor):
    def __init__(self):
        self.serial_com = '/dev/ttyACM0'
        self.baud_rate = 9600

        self.ser = serial.Serial(self.serial_com,self.baud_rate)

    def set_angle(self,angle):
        pass

    def get_angle(self):

        #add exception to close port
        return 360 * (float(self.ser.readline())) / 4096

