from response import Response


class SendGyroStabilizedVectorsResponse(Response):
    RESPONSE_SIZE = 23

    def __init__(self, values, time):
        super(SendGyroStabilizedVectorsResponse, self).__init__(time, values)

    def get_stab_mag_field_x(self):
        return self.values[1]

    def get_stab_mag_field_y(self):
        return self.values[2]

    def get_stab_mag_field_z(self):
        return self.values[3]

    def get_stab_accel_x(self):
        return self.values[4]

    def get_stab_accel_y(self):
        return self.values[5]

    def get_stab_accel_z(self):
        return self.values[6]

    def get_comp_ang_rate_x(self):
        return self.values[7]

    def get_comp_ang_rate_y(self):
        return self.values[8]

    def get_comp_ang_rate_z(self):
        return self.values[9]



