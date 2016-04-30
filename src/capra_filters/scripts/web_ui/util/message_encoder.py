#!/usr/bin/env python

import json
from genpy.message import Message

class MessageEncoder(json.JSONEncoder):
    def default(self, msg):
        if isinstance(msg, Message):
            new_msg = {}

            for key in msg.__slots__:
                new_msg[key] = self.default(msg.__getattribute__(key))

            return new_msg
        elif isinstance(msg, list):
            new_msg = []

            for value in msg:
                new_msg.append(self.default(value))

            return new_msg
        elif isinstance(msg, dict):
            new_msg = {}

            for key in msg.keys():
                new_msg[key] = self.default(msg[key])

            return new_msg
        else:
            return msg