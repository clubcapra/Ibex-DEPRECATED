import rospy


class Config:

    DEFAULT_SERIAL_PORT = "/dev/ttyUSB1001"
    DEFAULT_BAUDRATE = 115200#38400
    DEFAULT_ORIENTATION_COVARIANCE = """0.001225, 0,        0,
                                       0,        0.001225, 0,
                                       0,        0,        0.001225"""

    DEFAULT_ANGULAR_VELOCITY_COVARIANCE = """0.000144, 0, 0,
                                             0, 0.000144, 0, 0,
                                             0, 0.000144"""

    DEFAULT_LINEAR_ACCELERATION_COVARIANCE = """0.009604, 0,        0,
                                                0,        0.009604, 0,
                                                0,        0,        0.009604"""
    DEFAULT_PUBLISH_RATE = 60

    serial_port = None
    baudrate = None
    orientation_covariance = None
    angular_velocity_covariance = None
    linear_acceleration_covariance = None
    publish_rate = None

    @staticmethod
    def get_serial_port():
        if not Config.serial_port:
            Config.serial_port = rospy.get_param('~serial_port', Config.DEFAULT_SERIAL_PORT)
        return Config.serial_port

    @staticmethod
    def get_baudrate():
        if not Config.baudrate:
            Config.baudrate = rospy.get_param('~baudrate', Config.DEFAULT_BAUDRATE)
        return Config.baudrate

    @staticmethod
    def get_orientation_covariance():
        if not Config.orientation_covariance:
            mstr = rospy.get_param('~orientation_covariance', Config.DEFAULT_ORIENTATION_COVARIANCE)
            Config.orientation_covariance = [float(v.strip()) for v in mstr.split(",")]

        return Config.orientation_covariance

    @staticmethod
    def get_angular_velocity_covariance():
        if not Config.angular_velocity_covariance:
            mstr = rospy.get_param('~angular_velocity_covariance', Config.DEFAULT_ANGULAR_VELOCITY_COVARIANCE)
            Config.angular_velocity_covariance = [float(v.strip()) for v in mstr.split(",")]

        return Config.angular_velocity_covariance

    @staticmethod
    def get_linear_acceleration_covariance():
        if not Config.linear_acceleration_covariance:
            mstr = rospy.get_param('~linear_acceleration_covariance', Config.DEFAULT_LINEAR_ACCELERATION_COVARIANCE)
            Config.linear_acceleration_covariance = [float(v.strip()) for v in mstr.split(",")]

        return Config.linear_acceleration_covariance

    @staticmethod
    def get_publish_rate():
        if not Config.publish_rate:
            Config.publish_rate = rospy.get_param('~publish_rate', Config.DEFAULT_PUBLISH_RATE)
        return Config.publish_rate