from command import Command


class InitializeHardIronFieldCalibration(Command):
    COMMAND_BYTE = 0x40
    RESPONSE_TYPE = None

    def __init__(self):
        super(InitializeHardIronFieldCalibration, self).__init__(self.COMMAND_BYTE, self.RESPONSE_TYPE)

    def __str__(self):
        return chr(self.COMMAND_BYTE) + "\x71\x3e"
