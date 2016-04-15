#!/usr/bin/python

import rospy
import serial
import numpy
from time import sleep
from threading import Thread

class Color:
    PURPLE = '\033[95m'
    CYAN = '\033[96m'
    DARKCYAN = '\033[36m'
    BLUE = '\033[94m'
    GREEN = '\033[92m'
    YELLOW = '\033[93m'
    RED = '\033[91m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'
    END = '\033[0m'


class ImuCalibrationMenu:
    def __init__(self):
        rospy.init_node('imu_calibration', log_level=rospy.INFO)
        self.port = rospy.get_param("~serial_port", "/dev/ttyUSB2000")
        self.baud = rospy.get_param("~serial_baud", 115200)
        self.convergeRate = rospy.get_param("~converge_rate", "5")
        self.serialPort = SerialCom()
        self.hsi_done = False

        self.start_workflow()

    def start_workflow(self):
        self.display_menu()

        input_option = raw_input("\nPlease select an option: ")
        option = input_option.lower()

        if option != "q":
            if option == "1":
                self.calibrate_hsi()
            elif option == "2":
                self.calibrate_gps_antenna_a_offset()
            elif option == "3":
                self.calibrate_gps_compass_baseline()
            elif option == "4":
                self.display_gps_antenna_a_offset()
            elif option == "5":
                self.display_gps_compass_baseline()
            else:
                self.display_error("'{}' is not valid option.".format(option))

            self.start_workflow()

    def display_menu(self):
        print "\n{}Available Options{}".format(Color.BOLD, Color.END)
        print "1) {}Calibrate{} Hard Soft Iron Calibration".format(Color.GREEN, Color.END)
        print "2) {}Calibrate{} GPS Antenna A Offset".format(Color.GREEN, Color.END)
        print "3) {}Calibrate{} GPS Compass Baseline".format(Color.GREEN, Color.END)
        print "4) {}Display{} GPS Antenna A Offset".format(Color.BLUE, Color.END)
        print "5) {}Display{} GPS Compass Baseline".format(Color.BLUE, Color.END)
        print "Q) Quit"

    def display_error(self, error_message):
        print "{}{}ERROR!{}{} {}{}{}".format(Color.BOLD, Color.RED, Color.END, Color.END, Color.RED, error_message, Color.END)

    # calculate checksum for vectornav communication protocol
    def calculate_checksum(self, command):
        checksum = 0
        for c in command:
            checksum ^= ord(c)
        return checksum

    def calibrate_hsi(self):
        self.serialPort.connect(self.port, self.baud, 1000)

        rospy.loginfo("\nHard/Soft iron calibration before reset :")
        self.get_hsi()
        self.send_command("VNWRG,44,2,0," + self.convergeRate)  # reset calibration
        self.send_command("VNWRG,44,1,3," + self.convergeRate)  # start calibration

        # start thread reading HSI values
        self.hsi_done = False
        t = Thread(target=self.hsi_thread)
        t.daemon = True
        t.start()

        try:
            raw_input('Press ENTER to stop calibration.\n')
        except EOFError:
            pass

        self.hsi_done = True  # stop thread reading HSI values

        self.send_command("VNWRG,44,0,3," + self.convergeRate)  # stop calibration
        rospy.loginfo("\nHard/Soft iron calibration after calibration:")
        self.get_hsi()
        self.serialPort.close()

    def get_hsi(self):
        response = self.send_command("VNRRG,47")  # read HSI values
        rospy.loginfo(self.format_hsi_data(response))

    def format_hsi_data(self, response):
        index = response.find('*')
        data = response[9:index].split(',')
        return "\nx   " + data[0] + " " + data[1] + " " + data[2] + "   (MX - " + data[9] + ")" + "\n" \
                                                                                                  "y = " + data[
                   3] + " " + data[4] + " " + data[5] + " x (MY - " + data[10] + ")" + "\n" \
                                                                                       "z   " + data[6] + " " + data[
                   7] + " " + data[8] + "   (MZ - " + data[11] + ")" + "\n"

    def hsi_thread(self):
        while not self.hsi_done:
            sleep(3)
            self.get_hsi()

    def parse_command_response(self, response):
        index = response.find("*")
        return response[9:index].split(",")

    def calibrate_gps_antenna_a_offset(self):
        while True:
            try:
                offset_x = float(raw_input("Offset x : "))
            except ValueError:
                self.display_error("Input is not a float.")
                continue
            else:
                if offset_x > 0:
                    yes_no = raw_input('The offset x is greater than 0. Are you sure you wish to continue? (Y/N) ')

                    if yes_no.lower() == 'y':
                        break
                    else:
                        continue
                else:
                    break
        while True:
            try:
                offset_y = float(raw_input("Offset y : "))
            except ValueError:
                self.display_error("Input is not a float")
                continue
            else:
                break
        while True:
            try:
                offset_z = float(raw_input("Offset z : "))
            except ValueError:
                self.display_error("Input is not a float.")
                continue
            else:
                break

        self.serialPort.connect(self.port, self.baud, 1000)
        self.send_command("VNWRG,57,{},{},{}".format(offset_x, offset_y, offset_z))
        self.serialPort.close()

        self.display_gps_antenna_a_offset()

    def display_gps_antenna_a_offset(self):
        self.serialPort.connect(self.port, self.baud, 1000)
        response = self.send_command("VNRRG,57")
        self.serialPort.close()

        parsed = self.parse_command_response(response)
        offset = [float(parsed[i]) for i in range(0, 3)]

        print "\n{}Current GPS Antenna A Offset{}".format(Color.BOLD, Color.END)
        print "{}".format(offset)

    def calibrate_gps_compass_baseline(self):
        while True:
            try:
                baseline_x = float(raw_input("Baseline x : "))
            except ValueError:
                self.display_error("Input is not a float.")
                continue
            else:
                break
        while True:
            try:
                baseline_y = float(raw_input("Baseline y : "))
            except ValueError:
                self.display_error("Input is not a float")
                continue
            else:
                break
        while True:
            try:
                baseline_z = float(raw_input("Baseline z : "))
            except ValueError:
                self.display_error("Input is not a float.")
                continue
            else:
                break

        uncertainty_x = 0.05
        uncertainty_y = 0.05
        uncertainty_z = 0.05
        offset = [baseline_x, baseline_y, baseline_z]
        distance_between_antennas = numpy.linalg.norm(offset)

        print "Distance between antennas: {0:.2f}".format(distance_between_antennas)

        self.serialPort.connect(self.port, self.baud, 1000)
        self.send_command("VNWRG,93,{},{},{},{},{},{}".format(baseline_x, baseline_y, baseline_z, uncertainty_x, uncertainty_y, uncertainty_z))
        self.serialPort.close()

        self.display_gps_compass_baseline()

    def display_gps_compass_baseline(self):
        self.serialPort.connect(self.port, self.baud, 1000)
        response = self.send_command("VNRRG,93")
        self.serialPort.close()

        parsed = self.parse_command_response(response)
        offset = [float(parsed[i]) for i in range(0, 3)]
        uncertainty = [float(parsed[i]) for i in range(3, 6)]

        print "\n{}Current GPS Compass Baseline{}".format(Color.BOLD, Color.END)
        print "Offset : {}".format(offset)
        print "Uncertainty : {}".format(uncertainty)

    def send_command(self, command):
        checksum = self.calculate_checksum(command)
        self.serialPort.write("$" + command + "*" + (hex(checksum)[2:]).upper())
        self.serialPort.flush()

        response = False
        bytes = self.serialPort.read(48)
        while not response:
            bytes += self.serialPort.read(48)
            response = self.look_for_command(command, bytes)

        return response

    def look_for_command(self, command, bytes):
        index_command = bytes.find(command[0:7])
        if index_command != -1:
            indexLF = bytes.find('\n', index_command)
            if indexLF != -1:
                return bytes[index_command:indexLF]

        return False


class SerialCom:
    def __init__(self):
        pass

    def connect(self, port, baudrate, readTimeout):

        try:
            self.port = serial.Serial(
                port,
                baudrate,
                serial.EIGHTBITS,
                serial.PARITY_NONE,
                serial.STOPBITS_ONE,
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
        ImuCalibrationMenu()
    except serial.SerialException as e:
        rospy.loginfo("Error connecting to serial port: " + e.message)
    except rospy.ROSInterruptException:
        pass
