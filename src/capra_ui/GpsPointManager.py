#!/usr/bin/python

from PyQt4 import QtGui
import sys

from GpsPointManager.controllers.GpsPointManagerApp import GpsPointManagerApp


def main():
    app = QtGui.QApplication(sys.argv)
    form = GpsPointManagerApp()
    form.show()
    app.exec_()

if __name__ == '__main__':
    main()