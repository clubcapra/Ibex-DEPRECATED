from ..config import Config
from report_actual_position_response import ReportActualPositionResponse
from report_status_response import ReportStatusResponse
import rospy


class ResponseParser:
    chars = []
    source = None
    responseTypes = [ReportActualPositionResponse(), ReportStatusResponse()]
    current_response = None
    current_time = None

    def __init__(self):
        self.min_addr = Config.get_broadcast_address()
        self.max_addr = self.min_addr + Config.get_nb_motors()

    def add_char(self, c):
        try:
            if self.min_addr <= ord(c) <= self.max_addr:
                self.chars = []
                self.source = ord(c) - self.min_addr
                self.current_time = rospy.Time.now()
                self.current_response = None
            else:
                self.chars.append(c)
                if not self.current_response:
                    for r in self.responseTypes:
                        if r.is_response(self.chars):
                            self.current_response = type(r)(self.current_time, self.source)
                else:
                    if self.current_response.is_valid(self.chars):
                        self.current_response.parse(self.chars)
                        r = self.current_response
                        self.current_response = None
                        return r
        except Exception as ex:
            print ex.message

        return None



