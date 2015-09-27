__author__ = 'jstcyr'

from PyQt4 import QtGui, QtCore
from ..views import GpsPointManagerUi
from DialogAddPoint import DialogAddPoint


class GpsPointManagerApp(QtGui.QMainWindow, GpsPointManagerUi.Ui_MainWindow):
    def __init__(self, parent=None):
        super(GpsPointManagerApp, self).__init__(parent)
        self.setupUi(self)
        self.bind_events()

    def bind_events(self):
        QtCore.QObject.connect(self.pushButton_add, QtCore.SIGNAL("clicked()"), self.pushButton_addClicked)

    def pushButton_addClicked(self):
        dialog = DialogAddPoint(self)
        dialog.show()