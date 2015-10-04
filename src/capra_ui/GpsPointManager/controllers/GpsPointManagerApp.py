__author__ = 'jstcyr'

from PyQt4 import QtGui, QtCore
from ..views import GpsPointManagerUi
from ..models.CoordinatesList import CoordinatesList
from DialogAddPoint import DialogAddPoint


class GpsPointManagerApp(QtGui.QMainWindow, GpsPointManagerUi.Ui_MainWindow):
    def __init__(self, parent=None):
        super(GpsPointManagerApp, self).__init__(parent)
        self.setupUi(self)
        self.coordinates = CoordinatesList()
        self.refreshCoordinatesList()
        self.bind_events()

    def bind_events(self):
        self.pushButton_add.clicked.connect(self.pushButton_addClicked)
        self.pushButton_delete.clicked.connect(self.pushButton_deleteClicked)
        self.pushButton_up.clicked.connect(self.pushButton_upClicked)
        self.pushButton_down.clicked.connect(self.pushButton_downClicked)

    def pushButton_addClicked(self):
        dialog = DialogAddPoint(self)
        dialog.show()

    def pushButton_deleteClicked(self):
        self.coordinates.delete(self.listView_points.selectedIndexes())
        self.refreshCoordinatesList()

    def pushButton_upClicked(self):
        if self.coordinates.moveUp(self.listView_points.selectedIndexes()):
            self.refreshCoordinatesList()

    def pushButton_downClicked(self):
        if self.coordinates.moveDown(self.listView_points.selectedIndexes()):
            self.refreshCoordinatesList()

    def refreshCoordinatesList(self):
        self.listView_points.setModel(self.coordinates.getListModel())
        index = self.listView_points.model().index(self.coordinates.selectIndex,0)
        self.listView_points.selectionModel().setCurrentIndex(index, QtGui.QItemSelectionModel.SelectCurrent)

