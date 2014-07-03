from response import Response


class ReportActualPositionResponse(Response):

    def __init__(self, source = 0):
        super(ReportActualPositionResponse, self).__init__("RPA")
        self.source = source

    def parse(self, chars):
        self.encoder_count = self._parse_chars(chars)

    def get_encoder_count(self):
        return self.encoder_count


