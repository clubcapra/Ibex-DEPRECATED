class Motor:
    def __init__(self, publisher):
        self.publisher = publisher
        self.last_feedback
        self.last_status
        #Temporary value
        self.wheel_size = 0.25

    def set_velocity(self, velocity):
        pass

    def get_current_velocity(self):
        return self.last_feedback.measured_velocity * self.wheel_size

    #Return the current pull from the motor
    def get_motor_current(self):
        return self.last_feedback.motor_current

    #Return the current voltage of the battery
    def get_motor_voltage(self):
        return self.last_feedback.supply_voltage

    #Return the VAR (Voltage * Amperage) which is almost equal to the power of the motor
    def get_motor_watt(self):
        return self.last_feedback.supply_voltage * self.last_feedback.motor_current

    #Return the current temperature of the motor controller
    def get_motor_temperature(self):
        return self.last_feedback.channel_temperature

    #Return the last feedback message
    def _feedback_callback(self,msg):
        self.last_feedback = msg


    def encoder_radial_velocity(self):
        self.last_feedback.measured_velocity

    #Set the mode of the command
    #int8 MODE_STOPPED=-1
    #int8 MODE_VELOCITY=0 (DEFAULT)
    #int8 MODE_POSITION=1
    def set_mode(self, mode):
        pass

    #Return the last status message
    def _status_callback(self,msg):
        self.last_status = msg

    #Return the status of the controller
    def get_controller_status(self):

        fault = self.last_status.fault

        #monolithic for the win (no proper switch case in python )
        #Future improvement to add a dictionary for the fault status
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

        elif(fault == 0):
            return "No Problem detected"
        else:
            return "Unknown Fault Status"