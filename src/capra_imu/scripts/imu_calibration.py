#!/usr/bin/python

import rospy
import serial
from time import sleep
from threading import Thread


class ImuCalibration:
    def __init__(self):
        rospy.init_node('imu_calibration', log_level=rospy.INFO)
        self.port = rospy.get_param("~serial_port", "/dev/ttyUSB2000")
        self.baud = rospy.get_param("~serial_baud", 115200)
        self.convergeRate = rospy.get_param("~converge_rate", "5")
        self.serialPort = SerialCom()
        self.serialPort.connect(self.port, self.baud, 1000)
        self.calibrate()

    #calculate checksum for vectornav communication protocol
    def calculateChecksum(self, command):
        checksum = 0
        for c in command:
            checksum = checksum ^ ord(c)
        return checksum

    def calibrate(self):
        rospy.loginfo("\nHard/Soft iron calibration before reset:")
        self.getHSI()
        self.sendCommand("VNWRG,44,2,0,"+self.convergeRate) #reset calibration
        self.sendCommand("VNWRG,44,1,3,"+self.convergeRate) #start calibration

        #start thread reading HSI values
        self.done = False
        t = Thread(target=self.HSIThread)
        t.daemon = True
        t.start()

        try:
            raw_input("Press ENTER to stop calibration.\n")
        except EOFError:
            pass

        done = True #stop thread reading HSI values

        self.sendCommand("VNWRG,44,0,3,"+self.convergeRate) #stop calibration
        rospy.loginfo("\nHard/Soft iron calibration after calibration:")
        self.getHSI()
        self.serialPort.close()

    def getHSI(self):
        response = self.sendCommand("VNRRG,47") #read HSI values
        rospy.loginfo(self.formatHSIData(response))

    def formatHSIData(self,response):
        index = response.find('*')
        data = response[9:index].split(',')
        return  "\nx   "+data[0]+" "+data[1]+" "+data[2]+"   (MX - "+ data[9]+")"+"\n"\
                  "y = "+data[3]+" "+data[4]+" "+data[5]+" x (MY - "+data[10]+")"+"\n"\
                  "z   "+data[6]+" "+data[7]+" "+data[8]+"   (MZ - "+data[11]+")"+"\n"

    def HSIThread(self):
        while not self.done:
            sleep(3)
            self.getHSI()

    def sendCommand(self, command):
        checksum = self.calculateChecksum(command)
        self.serialPort.write("$" + command + "*" + (hex(checksum)[2:]).upper())
        self.serialPort.flush()

        response = False
        bytes = self.serialPort.read(48)
        while(response == False):
            bytes += self.serialPort.read(48)
            response = self.lookForCommand(command, bytes)

        return response

    def lookForCommand(self, command, bytes):
        indexCommand = bytes.find(command[0:7])
        if(indexCommand != -1):
            indexLF = bytes.find('\n', indexCommand)
            if(indexLF != -1):
                return bytes[indexCommand:indexLF]

        return False

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
        self.port.write(data)

    def read(self, size):
        reply = self.port.read(size)
        return reply

    def flush(self):
        self.port.write("\n")

    def close(self):
        self.port.close()

if __name__ == "__main__":
    try:
        ImuCalibration()
    except serial.SerialException as e:
        rospy.loginfo( "Error connecting to serial port: " + e.message)
    except rospy.ROSInterruptException:
        pass
