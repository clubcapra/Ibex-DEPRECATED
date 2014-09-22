#!/usr/bin/python

import sys
import string
import socket

def main():
    sock = socket.create_connection(("127.0.0.1",53001))
    sock.send("shutdown-server")
    sock.close()
    print "Server was shut down"
    

if __name__ == "__main__":
    main()

