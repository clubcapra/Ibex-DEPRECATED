from response import Response


class SendGyroStabilizedEulerAnglesResponse(Response):
    RESPONSE_SIZE = 11

    def __init__(self, values, time):
        super(SendGyroStabilizedEulerAnglesResponse, self).__init__(time, values)

    def get_roll(self):
        return self.values[1]

    def get_pitch(self):
        return self.values[2]

    def get_yaw(self):
        return self.values[3]

