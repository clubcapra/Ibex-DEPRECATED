__author__ = 'jstcyr'

from PyQt4 import QtGui
from ..views import DialogAddPointUi


class DialogAddPoint(QtGui.QDialog, DialogAddPointUi.Ui_Dialog_add_point):
    def __init__(self, parent=None):
        super(DialogAddPoint, self).__init__(parent)
        self.setupUi(self)
