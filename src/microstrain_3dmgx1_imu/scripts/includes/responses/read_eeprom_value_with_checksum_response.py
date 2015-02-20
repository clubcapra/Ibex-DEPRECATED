from response import Response


class ReadEEPromValueWithChecksumResponse(Response):
    RESPONSE_SIZE = 7

    def __init__(self, values, time):
        super(ReadEEPromValueWithChecksumResponse, self).__init__(time, values)

    def get_value(self):
        return self.values[1]

