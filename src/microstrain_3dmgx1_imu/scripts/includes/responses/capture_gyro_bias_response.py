from response import Response


class CaptureGyroBiasResponse(Response):
    RESPONSE_SIZE = 5

    def __init__(self, values, time):
        super(CaptureGyroBiasResponse, self).__init__(time, values)


