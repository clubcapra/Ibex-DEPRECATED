import rospy


class Config:

    DEFAULT_RESOLUTION = 4000.0
    DEFAULT_COUNTS_RPM = 542.29383
    DEFAULT_COUNTS_REVS = 16.15444
    DEFAULT_COUNTS_SEC = 4069.0
    DEFAULT_GEAR_RATIO = 26.25
    DEFAULT_WHEEL_DIAMETER = 0.305
    DEFAULT_ROBOT_WIDTH = 0.53
    DEFAULT_NB_MOTORS = 2
    DEFAULT_MAX_SPEED = 3.0
    DEFAULT_BROADCAST_ADDRESS = 0x80
    DEFAULT_SERIAL_PORT = "/dev/ttyACM1"
    DEFAULT_DEFAULT_ACCEL = 10
    DEFAULT_BAUDRATE = 112500
    DEFAULT_MAX_TIMEOUT_COUNT = 2
    DEFAULT_WATCHDOG_TIMEOUT = 150.0 / 1000
    DEFAULT_PUBLISH_RATE = 50
    DEFAULT_COVARIANCE_MATRIX = """1.0, 0,   0,   0,   0,   0,
                                0,   1.0, 0,   0,   0,   0,
                                0,   0,   1.0, 0,   0,   0,
                                0,   0,   0,   1.0, 0,   0,
                                0,   0,   0,   0,   1.0, 0,
                                0,   0,   0,   0,   0,   1.0"""
    DEFAULT_SPEED_RATIO = "1.0, 1.0, 1.0, 1.0"
    DEFAULT_POSITION_RATIO = "1.0, 1.0, 1.0, 1.0"

    DEFAULT_SWIVEL_ENC_TICKS = 4096
    DEFAULT_SWIVEL_GEAR_RATIO = 20

    DEFAULT_SWIVEL_ENC_SERIAL_PORT = '/dev/ttyACM0'
    DEFAULT_SWIVEL_ENC_BAUD_RATE = 9600


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
    default_accel = None
    baudrate = None
    max_timeout_count = None
    watchdog_timeout = None
    publish_rate = None
    covariance_matrix = None
    speed_ratio = None
    position_ratio = None
    swivel_encoder_ticks = None
    swivel_gear_ratio = None
    swivel_encoder_baud = None
    swivel_encoder_port = None

    @staticmethod
    def get_resolution():
        if not Config.resolution:
            Config.resolution = rospy.get_param('~resolution', Config.DEFAULT_RESOLUTION)
        return Config.resolution

    @staticmethod
    def get_counts_rpm():
        if not Config.counts_rpm:
            Config.counts_rpm = rospy.get_param('~counts_rpm', Config.DEFAULT_COUNTS_RPM)
        return Config.counts_rpm

    @staticmethod
    def get_counts_rps():
        return Config.get_counts_rpm() * 60

    @staticmethod
    def get_counts_revs():
        if not Config.counts_revs:
            Config.counts_revs = rospy.get_param('~counts_revs', Config.DEFAULT_COUNTS_REVS)
        return Config.counts_revs

    @staticmethod
    def get_counts_sec():
        if not Config.counts_sec:
            Config.counts_sec = rospy.get_param('~counts_sec', Config.DEFAULT_COUNTS_SEC)
        return Config.counts_sec

    @staticmethod
    def get_gear_ratio():
        if not Config.gear_ratio:
            Config.gear_ratio = rospy.get_param('~gear_ratio', Config.DEFAULT_GEAR_RATIO)
        return Config.gear_ratio

    @staticmethod
    def get_wheel_diameter():
        if not Config.wheel_diameter:
            Config.wheel_diameter = rospy.get_param('~wheel_diameter', Config.DEFAULT_WHEEL_DIAMETER)
        return Config.wheel_diameter

    @staticmethod
    def get_robot_width():
        if not Config.robot_width:
            Config.robot_width = rospy.get_param('~robot_width', Config.DEFAULT_ROBOT_WIDTH)
        return Config.robot_width

    @staticmethod
    def get_max_speed():
        if not Config.max_speed:
            Config.max_speed = rospy.get_param('~max_speed', Config.DEFAULT_MAX_SPEED)
        return Config.max_speed

    @staticmethod
    def get_broadcast_address():
        if not Config.broadcast_address:
            Config.broadcast_address = rospy.get_param('~broadcast_address', Config.DEFAULT_BROADCAST_ADDRESS)
        return Config.broadcast_address

    @staticmethod
    def get_serial_port():
        if not Config.serial_port:
            Config.serial_port = rospy.get_param('~serial_port', Config.DEFAULT_SERIAL_PORT)
        return Config.serial_port

    @staticmethod
    def get_default_accel():
        if not Config.default_accel:
            Config.default_accel = rospy.get_param('~default_accel', Config.DEFAULT_DEFAULT_ACCEL)
        return Config.default_accel

    @staticmethod
    def get_baudrate():
        if not Config.baudrate:
            Config.baudrate = rospy.get_param('~baudrate', Config.DEFAULT_BAUDRATE)
        return Config.baudrate

    @staticmethod
    def get_max_timeout_count():
        if not Config.max_timeout_count:
            Config.max_timeout_count = rospy.get_param('~max_timeout_count', Config.DEFAULT_MAX_TIMEOUT_COUNT)
        return Config.max_timeout_count

    @staticmethod
    def get_watchdog_timeout():
        if not Config.watchdog_timeout:
            Config.watchdog_timeout = rospy.get_param('~watchdog_timeout', Config.DEFAULT_WATCHDOG_TIMEOUT)
        return Config.watchdog_timeout

    @staticmethod
    def get_publish_rate():
        if not Config.publish_rate:
            Config.publish_rate = rospy.get_param('~publish_rate', Config.DEFAULT_PUBLISH_RATE)
        return Config.publish_rate

    @staticmethod
    def get_covariance_matrix():
        if not Config.covariance_matrix:
            mstr = rospy.get_param('~covariance_matrix', Config.DEFAULT_COVARIANCE_MATRIX)
            Config.covariance_matrix = [float(v.strip()) for v in mstr.split(",")]
        return Config.covariance_matrix

    @staticmethod
    def get_speed_ratio():
        if not Config.speed_ratio:
            sstr = rospy.get_param('~speed_ratio', Config.DEFAULT_SPEED_RATIO)
            Config.speed_ratio = [float(v.strip()) for v in sstr.split(",")]
        return Config.speed_ratio

    @staticmethod
    def get_position_ratio():
        if not Config.position_ratio:
            pstr = rospy.get_param('~position_ratio', Config.DEFAULT_POSITION_RATIO)
            Config.position_ratio = [float(v.strip()) for v in pstr.split(",")]
        return Config.position_ratio

    @staticmethod
    def get_swivel_encoder_port():
        if not Config.swivel_encoder_port:
            Config.watchdog_timeout = rospy.get_param('~swivel_encoder_port', Config.DEFAULT_SWIVEL_ENC_SERIAL_PORT)
        return Config.swivel_encoder_port

    @staticmethod
    def get_swivel_encoder_baud():
        if not Config.swivel_encoder_baud:
            Config.watchdog_timeout = rospy.get_param('~swivel_encoder_baud', Config.DEFAULT_SWIVEL_ENC_BAUD_RATE)
        return Config.swivel_encoder_baud

    @staticmethod
    def get_swivel_encoder_ticks():
        if not Config.swivel_encoder_ticks:
            Config.swivel_encoder_ticks = rospy.get_param('~swivel_encoder_ticks', Config.DEFAULT_SWIVEL_ENC_BAUD_RATE)
        return Config.swivel_encoder_ticks

    @staticmethod
    def get_swivel_gear_ratio():
        if not Config.swivel_gear_ratio:
            Config.swivel_gear_ratio = rospy.get_param('~swivel_gear_ratio', Config.DEFAULT_SWIVEL_GEAR_RATIO)
        return Config.swivel_gear_ratio

