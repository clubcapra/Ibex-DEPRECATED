class Command(object):

    def __init__(self, command_byte, response_type, command_data=None):
        self.command_byte = command_byte
        self.response_type = response_type
        self.command_data = command_data

    def parse_response(self, buffer):
        return self.response_type(buffer)

    def __str__(self):
        return chr(self.command_byte)

    def get_hex(self):
        return [hex(ord(c)) for c in self.__str__()]