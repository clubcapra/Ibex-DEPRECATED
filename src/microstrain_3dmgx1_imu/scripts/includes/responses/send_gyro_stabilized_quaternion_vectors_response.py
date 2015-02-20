from response import Response


class SendGyroStabilizedQuaternionVectorsResponse(Response):
    RESPONSE_SIZE = 31

    def __init__(self, values, time):
        super(SendGyroStabilizedQuaternionVectorsResponse, self).__init__(time, values)

    def get_quaternion(self):
        return self.values[1:5]

    def get_accel_x(self):
        return self.values[8]

    def get_accel_y(self):
        return self.values[9]

    def get_accel_z(self):
        return self.values[10]

    def get_comp_ang_rate_x(self):
        return self.values[11]

    def get_comp_ang_rate_y(self):
        return self.values[12]

    def get_comp_ang_rate_z(self):
        return self.values[13]

