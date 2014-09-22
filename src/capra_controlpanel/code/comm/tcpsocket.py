import traceback
import SocketServer
import sys
import communication

class TcpServer:
    
    def __init__(self):
        pass
        
    def start(self, port):
    
        server = ThreadedTCPServer( ("", port), SensorsClientHandler)
        print "tcpsocket: starting server on port " + str(port) + "..."
        try:
            server.serve_forever()
        except KeyboardInterrupt:
            server.shutdown()
            raise
            
        print "tcpsocket: server stopped"

class ReusableTCPServer(SocketServer.TCPServer):
    allow_reuse_address = True


class ThreadedTCPServer(SocketServer.ThreadingMixIn, ReusableTCPServer):
    pass

class SensorsClientHandler(SocketServer.BaseRequestHandler):

    def handle(self):
        print "tcpsocket: client connected"
        try:
            self.inner_handle()
        except:
            traceback.print_exc(file=sys.stdout)
            message = "tcpsocket: Command error"
            self.request.send(message)
            stacktrace = repr(traceback.format_stack())
            self.request.send(stacktrace)

    def inner_handle(self):
        data = None
        while not data:
            data = self.request.recv(1024)

        print ''
        print "tcpsocket: command received:' " + str(data) + "'"
        
        data = data.replace("\n", "")
        
        if data == "shutdown-server":
            self.server.shutdown()
            print "tcpsocket: remote shutdown requested. socket server stopping"
            communication.stop_all = True
            return
        
        status, reply = communication.instance.send_command(data)
        
        if not status:
            reply = "communication error"
        
        if reply is not None:
            print "tcpsocket: sending response to client: '" + reply + "'"
            self.request.send(reply)
        
