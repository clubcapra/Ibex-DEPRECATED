from ..config import Config
from abc import ABCMeta, abstractmethod

class Response(object):
    def __init__(self, response_header, time=None, source=0):
        self.header = response_header
        self.time = time
        self.source = source

    def is_response(self, chars):
        if len(chars) >= len(self.header):
            for i in range(len(self.header)):
                if self.header[i] != chars[i]:
                    return False
            return True
        return False

    def is_valid(self, chars):
        rcount = 0
        nb_motors = Config.get_nb_motors()

        for c in chars:
            if c == '\r':
                rcount += 1
            if rcount == nb_motors:
                return True

        return False

    @abstractmethod
    def parse(self, chars):
        pass

    def _parse_chars(self, chars):
        i = 0
        output = []

        while chars[i] != ' ':
            i += 1
        i += 1

        val = ""
        while i < len(chars):
            if chars[i] == '\r':
                output.insert(0, int(val))
                val = ""
            else:
                val += chars[i]
            i += 1

        return output




