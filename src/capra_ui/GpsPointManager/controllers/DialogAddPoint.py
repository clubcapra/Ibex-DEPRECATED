__author__ = 'jstcyr'

from PyQt4 import QtGui, QtCore
from ..views import DialogAddPointUi
from ..models.Coordinates import Coordinates
from ..utilities import CoordinatesUtils


class DialogAddPoint(QtGui.QDialog, DialogAddPointUi.Ui_Dialog_add_point):
    def __init__(self, parent=None):
        super(DialogAddPoint, self).__init__(parent)
        self.setupUi(self)
        self.parent = parent
        self.buttonBox.accepted.connect(self.saveButtonClicked)

    def saveButtonClicked(self):
        try:
            lat = CoordinatesUtils.ConvertToDecimalDegrees(self.lineEdit_latitude.text())
            long = CoordinatesUtils.ConvertToDecimalDegrees(self.lineEdit_longitude.text())
            coords = Coordinates(self.lineEdit_id.text(), lat, long)
            self.parent.coordinates.append(coords)
            self.parent.refreshCoordinatesList()
        except ValueError as e:
            print e
            self.setVisible(True)
            QtGui.QMessageBox.critical(self, QtCore.QString("Error"), QtCore.QString(e.message))