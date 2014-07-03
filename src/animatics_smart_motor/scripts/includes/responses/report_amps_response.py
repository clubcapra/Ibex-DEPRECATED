from response import Response


class ReportAmpsResponse(Response):

    def __init__(self, source = 0):
        super(ReportAmpsResponse, self).__init__("RPA")
        self.source = source

    def parse(self, chars):
        self.amps = self._parse_chars(chars)

    def get_amps(self):
        return self.amps
    

