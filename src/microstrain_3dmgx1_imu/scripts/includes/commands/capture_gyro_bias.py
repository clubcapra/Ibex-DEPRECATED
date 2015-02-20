from command import Command
from ..responses.capture_gyro_bias_response import CaptureGyroBiasResponse


class CaptureGyroBias(Command):
    COMMAND_BYTE = 0x06
    RESPONSE_TYPE = CaptureGyroBiasResponse

    def __init__(self):
        super(CaptureGyroBias, self).__init__(self.COMMAND_BYTE, self.RESPONSE_TYPE)

