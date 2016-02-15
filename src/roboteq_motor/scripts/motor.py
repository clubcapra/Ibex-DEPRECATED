from roboteq_msgs.msg import Feedback, Command, Status

class Motor:
    MODE_STOPPED = -1
    MODE_VELOCITY = 0
    MODE_POSITION = 1

    def __init__(self, y_axial_location, x_axial_location):
        self.y_axial_location = y_axial_location
        self.x_axial_location = x_axial_location

        self.last_feedback = None
        self.last_status = None

        self.cmd_publisher = None
        self.cmd_mode = 0

        self.wheel_diameter = 1.0
        self.gear_ratio = 1.0
        self.position_ratio = 1.0
        self.speed_ration = 1.0

    def link(self, cmd_publisher):
        self.cmd_publisher = cmd_publisher


    def set_velocity(self, velocity):
        radial_velocity = ((velocity * self.speed_ration) / self.wheel_diameter) * self.gear_ratio
        self.send_command(radial_velocity)


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


    def set_mode(self, mode):
        self.cmd_mode = mode

    def get_mode(self):
        return self.cmd_mode

    #Return the last status message
    def _status_callback(self,msg):
        self.last_status = msg

    #Return the status of the controller
    def get_controller_status(self):

        #Dictonary that contains the fault status
        status = { 1 : "Overheat",2:"Overvoltage",4:"Undervoltage",8:"Short Detected",16:"Estop",32:"SPEXExcitation",64:"MOSFET Failure",128:"Startup Config Problem",0:"No problem detected"}

        fault = self.last_status.fault

        return status.get(fault,"error")

    #Publish command on a topic
    def send_command(self, setpoint):
        command = Command()
        command.mode = self.get_mode()
        command.setpoint = setpoint

