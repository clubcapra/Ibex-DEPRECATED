class Motor:
    def __init__(self, publisher):
        self.publisher = publisher
        self.last_feedback
        self.last_status
        self.wheel_size = 0.25

    def set_velocity(self, velocity):
        pass

    def get_current_velocity(self):
        return self.last_feedback.measured_velocity * 0.25

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
        self.last_feedback.measured_velocity

    def set_mode(self, mode):
        pass
    def _status_callback(self,msg):
        self.last_status = msg

    def get_controller_status(self):
        fault = self.last_status.fault

        if(fault == 1):

            return "Overheat"

        elif(fault == 2):
            return "Overvoltage"

        elif(fault == 4):
            return "Undervoltage"

        elif(fault == 8):
            return "Short Detected"

        elif(fault == 16):
            return "Estop"

        elif(fault == 32):
            return "SPEXExcitation"
        elif(fault == 64):
            return "MOSFET Failure"
        elif(fault == 128):
            return "Startup Config Problem"

