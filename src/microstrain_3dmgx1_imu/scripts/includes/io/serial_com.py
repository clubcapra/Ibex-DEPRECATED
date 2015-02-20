import serial
from ..config import Config
import threading
import rospy
import struct


class SerialCom:
    MAX_BYTES_SKIPPED = 1000

    error_published = False
    write_lock = threading.Lock()

    def __init__(self, port_name, baudrate):
        self.serial_port = None
        self.baudrate = baudrate
        self.port_name = port_name


    def connect(self):
        try:
            if self.serial_port and self.serial_port.isOpen():
                rospy.logerr("Port already opened")

            self.serial_port = serial.Serial(port=self.port_name, baudrate=self.baudrate, bytesize=serial.EIGHTBITS, parity=serial.PARITY_NONE, stopbits=serial.STOPBITS_ONE)#, timeout=0.1)

            return True
        except serial.SerialException as ex:
            if not self.error_published:
                rospy.logerr(ex.message)
                self.error_published = True
            return False

    def disconnect(self):
        try:
            if self.serial_port:
                self.serial_port.close()
                self.serial_port = None
        except serial.SerialException:
            pass

    def send_command(self, command):
        if self.serial_port:
            try:
                with self.write_lock:
                    self.serial_port.write(str(command))
                return True
            except serial.SerialException:
                pass
        return False

    def read_response(self, command_type):
        try:
            cbyte = chr(command_type.COMMAND_BYTE)
            time = rospy.get_time()
            skipped_bytes = 0

            while self.serial_port.read(1) != cbyte and skipped_bytes < SerialCom.MAX_BYTES_SKIPPED:
                skipped_bytes += 1

            response_size = command_type.RESPONSE_TYPE.RESPONSE_SIZE
            return command_type.RESPONSE_TYPE((command_type.COMMAND_BYTE,) + struct.unpack(">" + "h" * ((response_size-1) / 2), self.serial_port.read(response_size - 1)), time)
        except serial.SerialException:
            return None

    def query_response(self, command):
        if self.send_command(command):
            return self.read_response(type(command))
        else:
            return False

