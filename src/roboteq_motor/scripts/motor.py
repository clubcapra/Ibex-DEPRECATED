
class Motor:
    def __init__(self, publisher):
        self.publisher = publisher

    def set_velocity(self, velocity):
        pass

    def get_current_velocity(self):
        pass

    def get_motor_current(self):
        pass

    def get_motor_temperature(self):
        pass

    def _feedback_callback(self):
        pass

    def encoder_radial_velocity(self):
        pass

    def set_mode(self, mode):
        pass