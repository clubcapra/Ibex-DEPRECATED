from command import Command
from ..responses.send_firmware_version_number_response import SendFirmwareVersionNumberResponse

class SendFirmwareVersionNumber(Command):
    COMMAND_BYTE = 0xF0
    RESPONSE_TYPE = SendFirmwareVersionNumberResponse

    def __init__(self):
        super(SendFirmwareVersionNumber, self).__init__(self.COMMAND_BYTE, self.RESPONSE_TYPE)

