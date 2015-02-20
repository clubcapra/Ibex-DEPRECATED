from command import Command
import struct
from ..responses.read_eeprom_value_with_checksum_response import ReadEEPromValueWithChecksumResponse

class ReadEEPromValueWithChecksum(Command):
    COMMAND_BYTE = 0x28
    RESPONSE_TYPE = ReadEEPromValueWithChecksumResponse

    def __init__(self, address):
        super(ReadEEPromValueWithChecksum, self).__init__(self.COMMAND_BYTE, self.RESPONSE_TYPE)
        self.address = address

    def __str__(self):
        return chr(self.COMMAND_BYTE) + struct.pack(">h", self.address)
