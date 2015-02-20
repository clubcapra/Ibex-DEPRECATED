import websocket

 
def request(req):
    global ws
    ws.send(req)
    return ws.recv() 


def list_instances():
    global ws
    return request('list').split()


def create_instance():
    global ws
    name = ""
    world = ""

    while not name:
        name = "".join(raw_input("Name: ").split())

    while not world:
        world = "".join(raw_input("World: ").split())

    r = request('create %s %s' % (name, world))
    if r == "Err":
        return None
    else:
        return [int(p) for p in r.split()]


def get_ports(instance):
    global ws
    ports = request('get_ports %s' % instance)
    if ports == "Err":
        return None
    else:
        return [int(p) for p in ports.split()]


def menu(instances):
    while True:
        for i, name in enumerate(instances):
            print "%d : %s" % (i + 1, name)
        print "%d : Create new instance" % (len(instances) + 1)
        print "%d : Kill instance" % (len(instances) + 2)

        choice = raw_input("Enter id:")
        if choice.isdigit():
            choice = int(choice)
            if choice > 0 and choice <= len(instances):
                ports = get_ports(instances[choice - 1])
                if ports is not None:
                    return ports
            elif choice == len(instances) + 1:
                ports = create_instance()
                if ports is not None:
                    return ports
            elif choice == len(instances) + 2:
                print "Kill"
                return


if __name__ == "__main__":
    ws = websocket.create_connection("ws://192.168.1.132:8888/ws")
    instances = list_instances()
    if len(instances) > 0:
        menu(instances)

    ws.close()