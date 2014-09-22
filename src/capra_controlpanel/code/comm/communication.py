import string
import sys
import traceback

import config
import re
from serial_com import SerialCom

#singleton style
global instance
global stop_all

# http://clubcapra.com/wiki/index.php/Contr%C3%B4leur_d%27alimentation
class Communication:
    """
    The communication class is responsible for responding to particular commands.
    A SerialComInstance can be pass to connect to a real serial or a mocked serial.
    """
    def __init__(self, SerialComInstance = SerialCom()):
        self.serial  = SerialComInstance
        
    def start(self):
                
        self.serial.connect( \
                config.serial_port, \
                config.baudrate, \
                config.readTimeout)

    def shutdown(self):
        print "communication: Closing serial connection."
        self.serial.close()


    def send_command(self, command_to_send):
        p1 = re.compile("[SETset]+ [0-9a-zA-Z]+ [ONFonf]+")
        p2 = re.compile("[GETget]+ [0-9a-zA-Z]+")
        
        if p1.match(command_to_send) is None and p2.match(command_to_send) is None:
            print "communication: Invalid command"
            return False, self.help()
        
        parts = string.split(command_to_send, " ")

        command = parts[0].upper()
        deviceId = self.get_sensor_addr(parts[1])
        if len(parts) > 2:
            state = parts[2]

        #SET stuff
        if command == "SET":
            try:
                try:
                    self.serial.write(command + " " + str(deviceId) + " " + state.upper() + "\n")
                except:
                    print "communication: error writing to serial port"
                    return False, None
                
                return True, None
            except:
                traceback.print_exc(file=sys.stdout)
                return False, self.help()
        
        #GET stuff
        if command == "GET":
            try:
                self.serial.write(command + " " + str(deviceId) + " " + "\n")
            except:
                print "communication: error writing to serial port"
                return False, None
            
            try:
                reply = self.serial.read(1024)
            except:
                traceback.print_exc(file=sys.stdout)
                return False, self.help()
        
            if reply == None:
                print "Communication: Invalid command"
                return False, None
        
            if reply == "":
                print "Communication: WARNING - Empty response from hardware"
        
            reply = command_to_send.split(" ")[1] + " " + reply
                
            return True, reply


    def get_sensor_addr(self, name):
        for var, value in vars(config).items():
            if var.lower() == name.lower():
                return value
    
    def get_all_sensors(self):
        devices = []
        for name, value in vars(config).items():
            if name[0] is not "_" and len(str(value)) == 2:
                devices.append(name)
        return devices

    def help(self):
        helpMessage =  "Commands availables are:\n"
        helpMessage += "  SET   <sensorName> <value>\n" 
        helpMessage += "  GET  <sensorName>\n" 
        helpMessage += "where <value> is ON or OFF and <sensorName> is one of:\n"
        helpMessage += "  " + "\n  ".join(self.get_all_sensors())
        helpMessage += "\n"
        return helpMessage

    def checkSum(self, hexArray):
        # compute checksum from array
        checksum = 0x00
        for e in hexArray:
            if e == None:
                continue
            checksum += e

        # limit checksum
        while checksum > 0xFF:
            checksum -= 0xFF

        return checksum
