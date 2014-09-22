
import tornado.httpserver
import tornado.websocket
import tornado.ioloop
import tornado.web

import communication

class WSHandler(tornado.websocket.WebSocketHandler):

    def open(self):
        print 'websocket: new connection'
      
    def on_message(self, data):
        print ""
        print "websocket: command received '" + data + "'"
        
        status, reply = communication.instance.send_command(data)
        
        if not status:
            reply = "communication error"
        
        if reply is not None:
            print "websocket: sending response to client: '" + reply + "'"
            self.write_message(reply)
 
    def on_close(self):
        print 'websocket connection closed'
 
class WebsocketServer:
    def __init__(self):
        pass
    
    def start(self, port):
        print "websocket: opening on port " + str(port)
        application = tornado.web.Application([(r'/ws', WSHandler), ])
        self.http_server = tornado.httpserver.HTTPServer(application)
        self.http_server.listen(port)
        tornado.ioloop.IOLoop.instance().start()
