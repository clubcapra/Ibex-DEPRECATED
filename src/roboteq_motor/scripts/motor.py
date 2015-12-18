class Motor:
    def __init__(self, publisher):
        self.publisher = publisher
        self.last_feedback
        self.last_status

    def set_velocity(self, velocity):
        pass

    def get_current_velocity(self):
        return self.last_feedback.measured_velocity

    def get_motor_current(self):
        return self.last_feedback.motor_current

    def get_motor_voltage(self):
        return self.last_feedback.supply_voltage

    def get_motor_watt(self):
        return self.last_feedback.supply_voltage * self.last_feedback.motor_current

    def get_motor_temperature(self):
        return self.last_feedback.channel_temperature

    def _feedback_callback(self,msg):
        self.last_feedback = msg


    def encoder_radial_velocity(self):
        pass

    def set_mode(self, mode):
        pass
    def _status_callback(self,msg):
        self.last_status = msg