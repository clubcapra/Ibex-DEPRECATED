


class Motor:
    def __init__(self, y_axial_location, x_axial_location):
        self.y_axial_location = y_axial_location
        self.x_axial_location = x_axial_location

        self.last_feedback = None
        self.last_status = None

        self.cmd_publisher = None

        #Temporary value
        self.temporary_wheel_size = 0.3302
       # self.wheel_size = 0.25 39.6/3.14

    def link(self, cmd_publisher):
        self.cmd_publisher = cmd_publisher


    def set_velocity(self, velocity):
        pass


    def get_current_velocity(self):
        return self.last_feedback.measured_velocity * self.temporary_wheel_size/2

    def get_axial_location(self):
        return [self.y_axial_location, self.x_axial_location]

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
        return 0

    #Return the last status message
    def _status_callback(self,msg):
        self.last_status = msg

    #Return the status of the controller
    def get_controller_status(self):

        #Dictonary that contains the fault status
        status = { 1 : "Overheat",2:"Overvoltage",4:"Undervoltage",8:"Short Detected",16:"Estop",32:"SPEXExcitation",64:"MOSFET Failure",128:"Startup Config Problem",0:"No problem detected"}

        fault = self.last_status.fault

        return status.get(fault,"error")
