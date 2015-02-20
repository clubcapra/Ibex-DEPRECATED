from command import Command
from ..responses.send_gyro_stabilized_euler_angles_response import SendGyroStabilizedEulerAnglesResponse


class SetContinuousMode(Command):
    COMMAND_BYTE = 0x10
    RESPONSE_TYPE = None

    def __init__(self, continuous_command_type):
        super(SetContinuousMode, self).__init__(self.COMMAND_BYTE, self.RESPONSE_TYPE)
        self.continuous_command_type = continuous_command_type

    def __str__(self):
        cmdbyte = chr(self.continuous_command_type.COMMAND_BYTE) if self.continuous_command_type else "0x00"
        return chr(self.COMMAND_BYTE) + "\x00" + cmdbyte
