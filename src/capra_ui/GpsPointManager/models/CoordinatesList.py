__author__ = 'jstcyr'
from PyQt4 import QtCore, QtGui
from Coordinates import Coordinates


class CoordinatesList(list):
    def __init__(self):
        super(CoordinatesList, self).__init__()
        self.selectIndex = 0
        self.append(Coordinates('test', 10, 10))
        self.append(Coordinates('test2', 20, 20))
        self.append(Coordinates('test3', 30, 30))
        self.append(Coordinates('test4', 40, 40))
        self.append(Coordinates('test5', 50, 50))

    def getListModel(self):
        list = QtCore.QStringList()
        model = QtGui.QStringListModel()

        for coords in self:
            list.append(coords.id)

        model.setStringList(list)

        return model

    def delete(self, modelindex):
        if modelindex and len(modelindex) > 0:
            self.remove(self.findItem(modelindex[0].data().toString()))

    def findIndex(self, id):
        idx = 0
        for coords in self:
            if coords.id == id:
                return idx
            else:
                idx = idx + 1

    def findItem(self, id):
        for coords in self:
            if coords.id == id:
                return coords

    def swap(self, idx1, idx2):
        temp = self[idx1]
        self[idx1] = self[idx2]
        self[idx2] = temp

    def moveUp(self, modelindex):
        success = False

        if modelindex and len(modelindex) > 0:
            idx = self.findIndex(modelindex[0].data().toString())
            if idx != 0:
                self.swap(idx, idx - 1)
                self.selectIndex = idx - 1
                success = True

        return success


    def moveDown(self, modelindex):
        success = False

        if modelindex and len(modelindex) > 0:
            idx = self.findIndex(modelindex[0].data().toString())
            if idx != len(self) - 1:
                self.swap(idx, idx + 1)
                self.selectIndex = idx + 1
                success = True

        return success