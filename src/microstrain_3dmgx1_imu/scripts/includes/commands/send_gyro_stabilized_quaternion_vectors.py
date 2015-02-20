from command import Command
from ..responses.send_gyro_stabilized_quaternion_vectors_response import SendGyroStabilizedQuaternionVectorsResponse


class SendGyroStabilizedQuaternionVectors(Command):
    COMMAND_BYTE = 0x0C
    RESPONSE_TYPE = SendGyroStabilizedQuaternionVectorsResponse

    def __init__(self):
        super(SendGyroStabilizedQuaternionVectors, self).__init__(self.COMMAND_BYTE, self.RESPONSE_TYPE)
