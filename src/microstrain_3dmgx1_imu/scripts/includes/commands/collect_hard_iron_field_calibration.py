from command import Command


class CollectHardIronFieldCalibration(Command):
    COMMAND_BYTE = 0x41
    RESPONSE_TYPE = None

    def __init__(self):
        super(CollectHardIronFieldCalibration, self).__init__(self.COMMAND_BYTE, self.RESPONSE_TYPE)

