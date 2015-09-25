from lib2to3.fixer_util import String
from PyQt4 import QtGui
import sys
from PyQt4.QtGui import QLayoutItem
import Test

class OpenCommand(QtGui.QDialog):
    def __init__(self, parent = None):
        QtGui.QDialog.__init__(self, None)

        #Hardcoding the QDialog
        grid = QtGui.QGridLayout()
        btnOk = QtGui.QPushButton(self.tr("Ok"))
        grid.addWidget(btnOk)
        btnCancel = QtGui.QPushButton(self.tr("Cancel"))
        grid.addWidget(btnCancel)
        self.setLayout(grid)

class ExampleApp(QtGui.QMainWindow, Test.Ui_MainWindow):
    num =1
    def __init__(self):
        super(self.__class__, self).__init__()
        self.setupUi(self)

        #used to close the layoutInst and layoutView
        self.closeInst.clicked.connect(self.closeWindow)
        self.closeView.clicked.connect(self.closeWindow)
        #used to move the selected item inside the lstInstruction
        self.btnUp.clicked.connect(self.moveInstruction)
        self.btnDown.clicked.connect(self.moveInstruction)
        #used to delete the selected item inside lstInstruction
        self.btnDelete.clicked.connect(self.deleteInstruction)
        self.btnAdd.clicked.connect(self.openActionFrame)

    #add a QLayout in argument if layoutName == layoutInstruction/layoutView, setVisible(false)
    def closeWindow(self):
        pass
        #self.layoutInstruction.

    #add a QPushButton in argument if btnName == btnUp/btnDown, move selected item inside the QList lstInstruction
    def moveInstruction(self):
        pass

    #Delete the selected item inside the QListWidget
    def deleteInstruction(self):
        row = self.lstInstruction.currentRow()
        self.lstInstruction.takeItem(row)

    #used to open a new fram which contains Actions associated with the selected item in QListWidget lstCommand
    def openActionFrame(self):
        #Test : Adding item into the QList lstInstruction
        self.lstInstruction.addItem('hello' + str(self.num))
        self.num += 1
        so = OpenCommand(self)
        so.exec_()

def main():
    app= QtGui.QApplication(sys.argv)
    form = ExampleApp()
    form.show()
    app.exec_()

if __name__ == '__main__':
    main()

