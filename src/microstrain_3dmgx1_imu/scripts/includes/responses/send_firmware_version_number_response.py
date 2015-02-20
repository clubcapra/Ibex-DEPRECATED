from response import Response


class SendFirmwareVersionNumberResponse(Response):
    RESPONSE_SIZE = 5

    def __init__(self, values, time):
        super(SendFirmwareVersionNumberResponse, self).__init__(time, values)

    def get_version(self):
        version = str(self.values[1])
        if len(version) < 5:
            version = "0" + version
        return version[0:2] + "." + version[2:3] + "." + version[3:]

