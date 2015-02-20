from command import Command
import struct


class WriteEEPromValue(Command):
    COMMAND_BYTE = 0x09
    RESPONSE_TYPE = None

    def __init__(self, address, data):
        super(WriteEEPromValue, self).__init__(self.COMMAND_BYTE, self.RESPONSE_TYPE)
        self.address = address
        self.data = data

    def __str__(self):
        return chr(self.COMMAND_BYTE) + "\x71" + chr(self.address) + struct.pack(">h", self.data) + "\xAA"
