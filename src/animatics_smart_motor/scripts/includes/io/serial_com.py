import serial
from ..config import Config
import thread
from ..responses.response_parser import ResponseParser
from ..commands import *
import time


class SerialCom:

    def __init__(self, port_name):
        self.serial_port = None
        self.port_name = port_name
        self.broadcast_address = Config.get_broadcast_address()
        self.response_parser = ResponseParser()

    def connect(self):
        try:
            if self.serial_port and self.serial_port.isOpen():
                self.serial_port.close()

            self.serial_port = serial.Serial(port=self.port_name, baudrate=9600, bytesize=serial.EIGHTBITS, parity=serial.PARITY_NONE, stopbits=serial.STOPBITS_ONE)
            self.send_command(0, OpenPort(baudrate=19200))
            self.serial_port.flush()
            time.sleep(1)

            self.serial_port.close()
            self.serial_port = serial.Serial(port=self.port_name, baudrate=19200, bytesize=serial.EIGHTBITS, parity=serial.PARITY_NONE, stopbits=serial.STOPBITS_ONE)


            thread.start_new_thread(self._read_thread, ())
            return True
        except serial.SerialException as ex:
            print ex.message
            return False


    def send_command(self, address, command):
        addr = chr(self.broadcast_address + address)

        for cmd in str(command).split("\n"):
            self._send(addr + str(cmd))

    def _send(self, msg):
        try:
            self.serial_port.write(msg + " ")
            return True
        except serial.SerialException:
            return False

    def _read_thread(self):
        try:
            while self.serial_port:
                response = self.response_parser.add_char(self.serial_port.read(1))
                if response:
                    pass
        except Exception as ex:
            print ex.message

