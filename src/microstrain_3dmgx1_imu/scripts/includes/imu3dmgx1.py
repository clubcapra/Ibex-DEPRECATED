from io.serial_com import SerialCom
from commands.set_continuous_mode import SetContinuousMode
from commands.send_gyro_stabilized_quaternion_vectors import SendGyroStabilizedQuaternionVectors
from commands.read_eeprom_value_with_checksum import ReadEEPromValueWithChecksum
from commands.initialize_hard_iron_field_calibration import InitializeHardIronFieldCalibration
from commands.collect_hard_iron_field_calibration import CollectHardIronFieldCalibration
from commands.compute_hard_iron_field_calibration import ComputeHardIronFieldCalibration
from commands.capture_gyro_bias import CaptureGyroBias
from commands.send_gyro_stabilized_vectors import SendGyroStabilizedVectors
from commands.send_firmware_version_number import SendFirmwareVersionNumber
import math
from tf.transformations import euler_from_quaternion, quaternion_from_euler
import rospy


class imu3dmgx1:
    SCALE_FROM_DOC = 32768000
    G_SCALE_TO_M_PER_SEC = 9.806649999788
    GYRO_GAIN_SCALE_ID = 130
    ACCEL_GAIN_SCALE_ID = 230
    DEFAULT_RATE = 100
    RPY_SCALE = math.pi / 32768

    gyro_gain_scale = 0
    accel_gain_scale = 0
    connected = False

    orientation = [0.0, 0.0, 0.0, 1.0]
    linear_acceleration = [0.0, 0.0, 0.0]
    angular_velocity = [0.0, 0.0, 0.0]
    last_update_time = 0

    def __init__(self, port, baudrate):
        self.port = port
        self.baudrate = baudrate
        self.serial_com = SerialCom(self.port, self.baudrate)

    def connect(self):
        if self.serial_com.connect():
            self.connected = self._initialize()
        else:
            self.connected = False

        return self.connected

    def _initialize(self):
        value = self._query_response(ReadEEPromValueWithChecksum(self.GYRO_GAIN_SCALE_ID)).get_value()
        self.gyro_gain_scale = self.SCALE_FROM_DOC / float(value)

        value = self._query_response(ReadEEPromValueWithChecksum(self.ACCEL_GAIN_SCALE_ID)).get_value()
        self.accel_gain_scale = self.SCALE_FROM_DOC / float(value) / self.G_SCALE_TO_M_PER_SEC

        # self._send_command(WriteEEPromValue(238, 4))
        # rospy.sleep(0.01)
        # self._send_command(WriteEEPromValue(240, 10))
        # rospy.sleep(0.01)
        # self._send_command(WriteEEPromValue(242, 250))
        # rospy.sleep(0.01)
        # self._send_command(WriteEEPromValue(246, 10))
        # rospy.sleep(0.01)

        rospy.loginfo("Firmware version: %s" % self.get_firmware_version())

        success = self.capture_bias() and self.ensure_g()
        if not success:
            self._disconnect()
        return success

    def update(self):
        response = self._query_response(SendGyroStabilizedQuaternionVectors())
        if response:
            self.last_update_time = response.time

            q = response.get_quaternion()
            self.orientation = [v/8192.0 for v in q]

            accel_x = response.get_accel_x() / self.accel_gain_scale
            accel_y = response.get_accel_y() / self.accel_gain_scale
            accel_z = response.get_accel_z() / self.accel_gain_scale
            self.linear_acceleration = [accel_x, accel_y, accel_z]

            angular_x = response.get_comp_ang_rate_x() / self.gyro_gain_scale
            angular_y = response.get_comp_ang_rate_x() / self.gyro_gain_scale
            angular_z = response.get_comp_ang_rate_x() / self.gyro_gain_scale
            self.angular_velocity = [angular_x, angular_y, angular_z]

    def _send_command(self, command):
        success = self.serial_com.send_command(command)
        if not success:
            self._disconnect()
        return success

    def _query_response(self, command):
        response = self.serial_com.query_response(command)
        if not response:
            self._disconnect()
        return response

    def _disconnect(self):
        if self.connected:
            rospy.logerr("Lost connection to the imu.")
        self.connected = False
        self.serial_com.disconnect()

    def calibrate(self, is_2d=True, magnitude_z=0, calibration_time=30):
        self._send_command(InitializeHardIronFieldCalibration())

        self._send_command(SetContinuousMode(CollectHardIronFieldCalibration))
        rospy.sleep(calibration_time)
        self._send_command(SetContinuousMode(None))

        self._send_command(ComputeHardIronFieldCalibration(is_2d, magnitude_z))

    def capture_bias(self):
        rospy.loginfo("Zeroing gyro now, don't move the IMU. This will take a few seconds...")
        response = self._query_response(CaptureGyroBias())
        if response and response.is_valid():
            rospy.sleep(0.5)
            rospy.loginfo("Gyro bias captured")
            return True
        return False

    def ensure_g(self):
        response = self._query_response(SendGyroStabilizedVectors())
        if response:
            accel_x = response.get_stab_accel_x() / self.accel_gain_scale
            accel_y = response.get_stab_accel_y() / self.accel_gain_scale
            accel_z = response.get_stab_accel_z() / self.accel_gain_scale
            measured_g = math.sqrt(accel_x*accel_x + accel_y*accel_y + accel_z*accel_z)
            err = abs(self.G_SCALE_TO_M_PER_SEC-measured_g)
            rospy.loginfo("Measured G = (%f, %f, %f) = %f" % (accel_x, accel_y, accel_z, measured_g))
            if err < 0.05:
                rospy.loginfo("Gravity detected correctly.")
                return True
            else:
                rospy.logerr("Measured gravity deviates by %f" % err)
        return False

    def get_firmware_version(self):
        response = self._query_response(SendFirmwareVersionNumber())
        if response:
            return response.get_version()
        return ""




