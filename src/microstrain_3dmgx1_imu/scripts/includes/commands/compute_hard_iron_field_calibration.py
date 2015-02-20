from command import Command
import struct


class ComputeHardIronFieldCalibration(Command):
    COMMAND_BYTE = 0x42
    RESPONSE_TYPE = None

    def __init__(self, is_2d, magnitude_z):
        super(ComputeHardIronFieldCalibration, self).__init__(self.COMMAND_BYTE, self.RESPONSE_TYPE)
        self.is_2d = is_2d
        self.magnitude_z = magnitude_z

    def __str__(self):
        if self.is_2d:
            dimension = "\x01"
        else:
            dimension = "\x00"

        return chr(self.COMMAND_BYTE) + "\x71\x3E" + dimension + struct.pack(">h", self.magnitude_z)
