from command import Command
from ..responses.send_gyro_stabilized_euler_angles_response import SendGyroStabilizedEulerAnglesResponse


class SendGyroStabilizedEulerAngles(Command):
    COMMAND_BYTE = 0x0E
    RESPONSE_TYPE = SendGyroStabilizedEulerAnglesResponse

    def __init__(self):
        super(SendGyroStabilizedEulerAngles, self).__init__(self.COMMAND_BYTE, self.RESPONSE_TYPE)
