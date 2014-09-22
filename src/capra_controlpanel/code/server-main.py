#!/usr/bin/python


import thread
import time
import socket
import config

from comm.websocket import WebsocketServer
from comm.tcpsocket import TcpServer

import comm.communication
from comm.communication import Communication
from comm.serial_com_mock import SerialComMock

import sys

if __name__ == "__main__":
    
    #Try to close other instances if they exist
    try:
        sock = socket.create_connection(("127.0.0.1", config.tcp_port))
        sock.send("shutdown-server")
        sock.close()
        print "tcpsocket: Shutting down running server.."
        time.sleep(2)
    except:
        pass
    
    # The communication interface to the sensors is defined globally
    if config.simulation is True:
        comm.communication.instance = Communication(SerialComMock()) # a mocked serial implementation
    else:
        comm.communication.instance = Communication() # real serial
        
    comm.communication.instance.start()
    comm.communication.stop_all = False

    tcp_server = None
    if config.use_tcp_server is True:
        tcp_server = TcpServer()
        thread.start_new_thread(tcp_server.start, (config.tcp_port, ))

    web_socket_server = None
    if config.use_websockets is True:
        web_socket_server = WebsocketServer()
        thread.start_new_thread(web_socket_server.start, (config.websocket_port, ))
        
    while not comm.communication.stop_all:
        time.sleep(1)

