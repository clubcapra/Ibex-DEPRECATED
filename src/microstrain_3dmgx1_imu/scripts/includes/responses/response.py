import rospy


class Response(object):
    valid = True

    def __init__(self, time, values):
        self.time = time
        if self._validate_checksum(values):
            self.values = values
        else:
            rospy.logwarn("Invalid checksum.")
            self.valid = False

    def _validate_checksum(self, values):
        checksum = 0
        for i in range(len(values)-1):
            checksum += values[i]
        return checksum & 0xffff == values[-1] & 0xffff

    def is_valid(self):
        return self.valid