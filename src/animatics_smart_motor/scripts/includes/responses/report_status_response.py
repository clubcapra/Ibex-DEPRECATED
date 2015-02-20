from response import Response
from status import Status


class ReportStatusResponse(Response):

    def __init__(self, time=None, source=0):
        super(ReportStatusResponse, self).__init__("RW", time, source)

    def parse(self, chars):
        self.status = [Status(v) for v in self._parse_chars(chars)]

    def get_status(self):
        return self.status


