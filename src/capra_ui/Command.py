
import sys

class Command:
    def __init__(self, name, parentName, title, controls):
        self.name = name
        self.parentName = parentName
        self.title = title
        self.controls = controls

    def compose_name(self):
        return self.parentName + self.name

class CommmandControl:
    def __init__(self, label, arg, type, default):
        self.label = label
        self.arg = arg
        self.type = type
        self.default = default



co = Command("nom cool", "parent cool", "titre fucking cool", ["hello","toi"]);
print co.title
