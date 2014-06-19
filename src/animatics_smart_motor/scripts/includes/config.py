import rospy

class Config:
    DEFAULT_RESOLUTION = 4000
    DEFAULT_COUNTS_RPM = 542.29383
    DEFAULT_COUNTS_REVS = 16.15444
    DEFAULT_COUNTS_SEC = 4069
    DEFAULT_GEAR_RATIO = 40
    DEFAULT_WHEEL_DIAMETER = 0.305
    DEFAULT_ROBOT_WIDTH = 0.6096
    DEFAULT_NB_MOTORS = 2
    DEFAULT_MAX_SPEED = 3.0
    DEFAULT_BROADCAST_ADDRESS = 0x80
    DEFAULT_SERIAL_PORT = "/dev/ttyUSB0"

    resolution = None
    counts_rpm = None
    counts_revs = None
    counts_sec = None
    gear_ratio = None
    wheel_diameter = None
    robot_width = None
    nb_motors = None
    max_speed = None
    broadcast_address = None
    serial_port = None

    @staticmethod
    def get_resolution():
        if not Config.resolution:
            Config.resolution = rospy.get_param('resolution', Config.DEFAULT_RESOLUTION)
        return Config.resolution

    @staticmethod
    def get_counts_rpm():
        if not Config.counts_rpm:
            Config.counts_rpm = rospy.get_param('counts_rpm', Config.DEFAULT_COUNTS_RPM)
        return Config.counts_rpm

    @staticmethod
    def get_counts_rps():
        return Config.get_counts_rpm() * 60

    @staticmethod
    def get_counts_revs():
        if not Config.counts_revs:
            Config.counts_revs = rospy.get_param('counts_revs', Config.DEFAULT_COUNTS_REVS)
        return Config.counts_revs

    @staticmethod
    def get_counts_sec():
        if not Config.counts_sec:
            Config.counts_sec = rospy.get_param('counts_sec', Config.DEFAULT_COUNTS_SEC)
        return Config.counts_sec

    @staticmethod
    def get_gear_ratio():
        if not Config.gear_ratio:
            Config.gear_ratio = rospy.get_param('gear_ratio', Config.DEFAULT_GEAR_RATIO)
        return Config.gear_ratio

    @staticmethod
    def get_wheel_diameter():
        if not Config.wheel_diameter:
            Config.wheel_diameter = rospy.get_param('wheel_diameter', Config.DEFAULT_WHEEL_DIAMETER)
        return Config.wheel_diameter

    @staticmethod
    def get_robot_width():
        if not Config.robot_width:
            Config.robot_width = rospy.get_param('robot_width', Config.DEFAULT_ROBOT_WIDTH)
        return Config.robot_width

    @staticmethod
    def get_nb_motors():
        if not Config.nb_motors:
            Config.nb_motors = rospy.get_param('nb_motors', Config.DEFAULT_NB_MOTORS)
        return Config.nb_motors

    @staticmethod
    def get_max_speed():
        if not Config.max_speed:
            Config.max_speed = rospy.get_param('max_speed', Config.DEFAULT_MAX_SPEED)
        return Config.max_speed

    @staticmethod
    def get_broadcast_address():
        if not Config.broadcast_address:
            Config.broadcast_address = rospy.get_param('broadcast_address', Config.DEFAULT_BROADCAST_ADDRESS)
        return Config.broadcast_address

    @staticmethod
    def get_serial_port():
        if not Config.serial_port:
            Config.serial_port = rospy.get_param('serial_port', Config.DEFAULT_SERIAL_PORT)
        return Config.serial_port