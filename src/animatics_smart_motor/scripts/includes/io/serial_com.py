import serial
from ..config import Config
import threading
from ..responses.response_parser import ResponseParser
from ..commands import *
import time
import rospy
import traceback


class SerialCom:

    listeners = {}
    read_thread = None
    error_published = False
    write_lock = threading.Lock()
    connected = False

    def __init__(self, port_name):
        self.serial_port = None
        self.port_name = port_name
        self.broadcast_address = Config.get_broadcast_address()
        self.response_parser = ResponseParser()

    def connect(self):
        try:
            if self.serial_port and self.serial_port.isOpen():
                rospy.logerr("Port already opened")

            self.serial_port = serial.Serial(port=self.port_name, baudrate=9600, bytesize=serial.EIGHTBITS, parity=serial.PARITY_NONE, stopbits=serial.STOPBITS_ONE, timeout=0.1)
            # Attendre que les moteurs repondent de quoi.
            received_data = False
            while not received_data:
                # Attention, les moteurs pourraient ne pas etre a 9600baud et mal recevoir la commande,
                # mais ils semblent toujours renvoyer des donnees.
                self.send_command(0, Echo(True), True)
                self.send_command(0, ReportStatus(), True)
                if len(self.serial_port.read()) > 0:
                    received_data = True

            self.send_command(0, SetBaudrate(9600), True)
            self.send_command(0, Echo(False), True)
            rospy.sleep(0.1)
            self.serial_port.flushInput()

            self.connected = True

            self.read_thread = threading.Thread(target=self._read_thread)
            self.read_thread.daemon = True
            self.read_thread.start()

            return True
        except serial.SerialException as ex:
            if not self.error_published:
                rospy.logerr(ex.message)
                self.error_published = True
            return False

    def disconnect(self):
        try:
            self.connected = False
            if self.serial_port:
                self.serial_port.close()
                self.serial_port = None
            if self.read_thread:
                self.read_thread.join()
                self.read_thread = None
        except serial.SerialException:
            pass

    def change_baudrate(self, baudrate):
        self.send_command(0, SetBaudrate(baudrate))
        time.sleep(0.1)
        self.serial_port.setBaudrate(baudrate)

    def send_command(self, address, command, force=False):
        addr = chr(self.broadcast_address + address)

        for cmd in str(command).split("\n"):
            self._send(addr + str(cmd), force)

    def _send(self, msg, force=False):
        if self.connected or force:
            try:
                with self.write_lock:
                    self.serial_port.write(msg + " ")
                return True
            except serial.SerialException:
                pass
        return False

    def _read_thread(self):
        try:
            while self.connected:
                c = self.serial_port.read(1)
                if len(c) == 1:
                    response = self.response_parser.add_char(c)
                    if response:
                        if type(response) in self.listeners:
                            listener = self.listeners[type(response)]
                            listener(response)
                else:
                    break
        except Exception as ex:
            print traceback.format_exc()

    def add_listener(self, response_type, listener):
        self.listeners[response_type] = listener
