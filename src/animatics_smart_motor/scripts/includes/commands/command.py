class Command(object):
    response_type = None
    
    def __init__(self, response_type=None):
        self.response_type = response_type

    def __str__(self):
        return ""