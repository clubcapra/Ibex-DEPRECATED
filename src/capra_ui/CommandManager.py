import xml.etree.ElementTree as ET
from Command import Command
from Command import CommmandControl

class CommandManager:
    def __init__(self):

        self.commands = dict()

        tree = ET.parse('Command.xml')
        commands = tree.getroot()
        for command in commands:
            c = self.parse_command(command, "")
            types = dict()
            for type in command.find("types"):
                t = self.parse_command(type, c.name)
                types[t.name] = t
            self.commands[c.name] = [c, types]

        print self.commands


    def parse_command(self, command, parentName):

        name = command.attrib["name"]
        title = command.find("title").text

        ctrls = list()
        for control in command.find("controls"):
            ctrls.append(CommmandControl(control.attrib["label"],
                                         control.attrib["arg"],
                                         control.attrib["type"],
                                         control.text))

        c = Command(name, parentName, title, ctrls)
        return c

if __name__ == "__main__":
    CommandManager()