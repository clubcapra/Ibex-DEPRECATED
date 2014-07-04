from response import Response


class ReportAmpsResponse(Response):

    def __init__(self, time=None, source=0):
        super(ReportAmpsResponse, self).__init__("RPA", time, source)

    def parse(self, chars):
        self.amps = self._parse_chars(chars)

    def get_amps(self):
        return self.amps
    

