import serial


class SerialCom:
    def __init__(self, port_name):
        self.serial_port = None
        self.port_name = port_name

    def connect(self):
        if self.serial_port and self.serial_port.isOpen():
            self.serial_port.close()

        self.serial_port = serial.Serial(port=self.port_name, baudrate=9600, bytesize=serial.EIGHTBITS, parity=serial.PARITY_NONE, stopbits=serial.STOPBITS_ONE)