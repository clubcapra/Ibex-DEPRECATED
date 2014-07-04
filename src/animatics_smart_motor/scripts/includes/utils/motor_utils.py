from ..config import Config
import math

class MotorUtils:
    distance_per_count = None

    @staticmethod
    def counts_to_degrees(counts):
        return counts * (360/Config.get_resolution()) / Config.get_gear_ratio()

    @staticmethod
    def counts_to_distance(counts):
        return MotorUtils.get_distance_per_count() * counts

    @staticmethod
    def sec_to_counts(sec):
        return sec * Config.get_counts_sec()

    @staticmethod
    def degree_to_counts(angle):
        return angle / (360 / Config.get_resolution()) * Config.get_gear_ratio()

    @staticmethod
    def rpm_to_counts(rpm):
        return int(round(rpm * Config.get_counts_rpm() * Config.get_gear_ratio()))

    @staticmethod
    def ms_to_rpm(ms):
        return (60 * ms)/(Config.get_wheel_diameter() * math.pi)

    @staticmethod
    def rps_to_counts(rps):
        return rps * Config.get_counts_rps()

    @staticmethod
    def revs_to_counts(revs):
        return int(revs * Config.get_counts_revs())

    @staticmethod
    def revs2_to_ms2(revs2):
        wheel_diameter = Config.get_wheel_diameter()
        w = revs2 / Config.get_gear_ratio() * wheel_diameter * math.pi
        ms2 = w * wheel_diameter / 2
        return ms2

    @staticmethod
    def ms2_to_revs2(ms2):
        wheel_diameter = Config.get_wheel_diameter()
        w = ms2 / (wheel_diameter / 2)
        revs2 = w / (math.pi * wheel_diameter)
        return revs2

    @staticmethod
    def get_distance_per_count():
        if MotorUtils.distance_per_count is None:
            MotorUtils.distance_per_count = math.pi * Config.get_wheel_diameter() * ((360/Config.get_resolution())/360)/ Config.get_gear_ratio()
        return MotorUtils.distance_per_count

