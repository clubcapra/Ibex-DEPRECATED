class Status:
    DRIVE_READY = 1 << 0
    MOTOR_OFF = 1 << 1
    MOVING = 1 << 2
    VOLTAGE_FAULT = 1 << 3
    OVER_CURRENT = 1 << 4
    EXCESSIVE_TEMPERATURE = 1 << 5
    EXCESSIVE_POSITION = 1 << 6
    VELOCITY_LIMIT = 1 << 7

    ERROR_FLAG = VOLTAGE_FAULT | EXCESSIVE_TEMPERATURE | EXCESSIVE_POSITION | VELOCITY_LIMIT

    def __init__(self, value):
        self.value = value

    def is_flag(self, flag):
        return (self.value & flag) == flag

    def is_error(self):
        return (self.value & ~Status.ERROR_FLAG) != self.value

    def get_value(self):
        return self.value

    def __str__(self):
        flags = {"DRIVE_READY": self.is_flag(Status.DRIVE_READY),
                 "MOTOR_OFF": self.is_flag(Status.MOTOR_OFF),
                 "MOVING": self.is_flag(Status.MOVING),
                 "VOLTAGE_FAULT": self.is_flag(Status.VOLTAGE_FAULT),
                 "OVER_CURRENT": self.is_flag(Status.OVER_CURRENT),
                 "EXCESSIVE_TEMPERATURE": self.is_flag(Status.EXCESSIVE_TEMPERATURE),
                 "EXCESSIVE_POSITION": self.is_flag(Status.EXCESSIVE_POSITION),
                 "VELOCITY_LIMIT": self.is_flag(Status.VELOCITY_LIMIT)
                 }
        return " ".join([name for name, isflag in flags.items() if isflag])
    