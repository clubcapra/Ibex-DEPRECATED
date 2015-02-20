from command import Command
from ..responses.send_gyro_stabilized_vectors_response import SendGyroStabilizedVectorsResponse


class SendGyroStabilizedVectors(Command):
    COMMAND_BYTE = 0x02
    RESPONSE_TYPE = SendGyroStabilizedVectorsResponse

    def __init__(self):
        super(SendGyroStabilizedVectors, self).__init__(self.COMMAND_BYTE, self.RESPONSE_TYPE)
