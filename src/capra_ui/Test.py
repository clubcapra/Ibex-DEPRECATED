# -*- coding: utf-8 -*-

# Form implementation generated from reading ui file 'Test.ui'
#
# Created by: PyQt4 UI code generator 4.11.4
#
# WARNING! All changes made in this file will be lost!

from PyQt4 import QtCore, QtGui

try:
    _fromUtf8 = QtCore.QString.fromUtf8
except AttributeError:
    def _fromUtf8(s):
        return s

try:
    _encoding = QtGui.QApplication.UnicodeUTF8
    def _translate(context, text, disambig):
        return QtGui.QApplication.translate(context, text, disambig, _encoding)
except AttributeError:
    def _translate(context, text, disambig):
        return QtGui.QApplication.translate(context, text, disambig)

class Ui_MainWindow(object):
    def setupUi(self, MainWindow):
        MainWindow.setObjectName(_fromUtf8("MainWindow"))
        MainWindow.resize(1008, 690)
        self.centralwidget = QtGui.QWidget(MainWindow)
        self.centralwidget.setObjectName(_fromUtf8("centralwidget"))
        self.verticalLayoutWidget = QtGui.QWidget(self.centralwidget)
        self.verticalLayoutWidget.setGeometry(QtCore.QRect(10, 10, 321, 631))
        self.verticalLayoutWidget.setObjectName(_fromUtf8("verticalLayoutWidget"))
        self.verticalLayout = QtGui.QVBoxLayout(self.verticalLayoutWidget)
        self.verticalLayout.setObjectName(_fromUtf8("verticalLayout"))
        self.label = QtGui.QLabel(self.verticalLayoutWidget)
        self.label.setObjectName(_fromUtf8("label"))
        self.verticalLayout.addWidget(self.label)
        self.lstCommand = QtGui.QListWidget(self.verticalLayoutWidget)
        self.lstCommand.setObjectName(_fromUtf8("lstCommand"))
        self.verticalLayout.addWidget(self.lstCommand)
        self.gridLayout_2 = QtGui.QGridLayout()
        self.gridLayout_2.setObjectName(_fromUtf8("gridLayout_2"))
        self.btnAdd = QtGui.QPushButton(self.verticalLayoutWidget)
        self.btnAdd.setObjectName(_fromUtf8("btnAdd"))
        self.gridLayout_2.addWidget(self.btnAdd, 0, 1, 1, 1)
        spacerItem = QtGui.QSpacerItem(40, 20, QtGui.QSizePolicy.Expanding, QtGui.QSizePolicy.Minimum)
        self.gridLayout_2.addItem(spacerItem, 0, 0, 1, 1)
        spacerItem1 = QtGui.QSpacerItem(40, 20, QtGui.QSizePolicy.Expanding, QtGui.QSizePolicy.Minimum)
        self.gridLayout_2.addItem(spacerItem1, 0, 2, 1, 1)
        self.verticalLayout.addLayout(self.gridLayout_2)
        self.splitter = QtGui.QSplitter(self.centralwidget)
        self.splitter.setGeometry(QtCore.QRect(340, 10, 661, 601))
        self.splitter.setOrientation(QtCore.Qt.Vertical)
        self.splitter.setObjectName(_fromUtf8("splitter"))
        self.gridLayoutWidget = QtGui.QWidget(self.splitter)
        self.gridLayoutWidget.setObjectName(_fromUtf8("gridLayoutWidget"))
        self.layoutInstruction = QtGui.QGridLayout(self.gridLayoutWidget)
        self.layoutInstruction.setObjectName(_fromUtf8("layoutInstruction"))
        self.btnDelete = QtGui.QPushButton(self.gridLayoutWidget)
        self.btnDelete.setObjectName(_fromUtf8("btnDelete"))
        self.layoutInstruction.addWidget(self.btnDelete, 2, 1, 1, 1, QtCore.Qt.AlignRight)
        self.verticalLayout_4 = QtGui.QVBoxLayout()
        self.verticalLayout_4.setObjectName(_fromUtf8("verticalLayout_4"))
        self.btnUp = QtGui.QPushButton(self.gridLayoutWidget)
        self.btnUp.setObjectName(_fromUtf8("btnUp"))
        self.verticalLayout_4.addWidget(self.btnUp)
        self.btnDown = QtGui.QPushButton(self.gridLayoutWidget)
        self.btnDown.setObjectName(_fromUtf8("btnDown"))
        self.verticalLayout_4.addWidget(self.btnDown)
        self.layoutInstruction.addLayout(self.verticalLayout_4, 1, 0, 1, 1)
        self.horizontalLayout_3 = QtGui.QHBoxLayout()
        self.horizontalLayout_3.setObjectName(_fromUtf8("horizontalLayout_3"))
        self.label_2 = QtGui.QLabel(self.gridLayoutWidget)
        self.label_2.setObjectName(_fromUtf8("label_2"))
        self.horizontalLayout_3.addWidget(self.label_2)
        spacerItem2 = QtGui.QSpacerItem(40, 20, QtGui.QSizePolicy.Expanding, QtGui.QSizePolicy.Minimum)
        self.horizontalLayout_3.addItem(spacerItem2)
        self.closeInst = QtGui.QToolButton(self.gridLayoutWidget)
        self.closeInst.setObjectName(_fromUtf8("closeInst"))
        self.horizontalLayout_3.addWidget(self.closeInst)
        self.layoutInstruction.addLayout(self.horizontalLayout_3, 0, 1, 1, 1)
        self.lstInstruction = QtGui.QListWidget(self.gridLayoutWidget)
        self.lstInstruction.setObjectName(_fromUtf8("lstInstruction"))
        self.layoutInstruction.addWidget(self.lstInstruction, 1, 1, 1, 1)
        self.verticalLayoutWidget_4 = QtGui.QWidget(self.splitter)
        self.verticalLayoutWidget_4.setObjectName(_fromUtf8("verticalLayoutWidget_4"))
        self.layoutView = QtGui.QVBoxLayout(self.verticalLayoutWidget_4)
        self.layoutView.setObjectName(_fromUtf8("layoutView"))
        self.horizontalLayout_7 = QtGui.QHBoxLayout()
        self.horizontalLayout_7.setObjectName(_fromUtf8("horizontalLayout_7"))
        self.label_6 = QtGui.QLabel(self.verticalLayoutWidget_4)
        self.label_6.setObjectName(_fromUtf8("label_6"))
        self.horizontalLayout_7.addWidget(self.label_6)
        spacerItem3 = QtGui.QSpacerItem(40, 20, QtGui.QSizePolicy.Expanding, QtGui.QSizePolicy.Minimum)
        self.horizontalLayout_7.addItem(spacerItem3)
        self.closeView = QtGui.QToolButton(self.verticalLayoutWidget_4)
        self.closeView.setObjectName(_fromUtf8("closeView"))
        self.horizontalLayout_7.addWidget(self.closeView)
        self.layoutView.addLayout(self.horizontalLayout_7)
        self.graphicsView = QtGui.QGraphicsView(self.verticalLayoutWidget_4)
        self.graphicsView.setObjectName(_fromUtf8("graphicsView"))
        self.layoutView.addWidget(self.graphicsView)
        self.verticalLayoutWidget.raise_()
        self.verticalLayoutWidget_4.raise_()
        self.gridLayoutWidget.raise_()
        self.verticalLayoutWidget.raise_()
        MainWindow.setCentralWidget(self.centralwidget)
        self.menubar = QtGui.QMenuBar(MainWindow)
        self.menubar.setGeometry(QtCore.QRect(0, 0, 1008, 21))
        self.menubar.setObjectName(_fromUtf8("menubar"))
        MainWindow.setMenuBar(self.menubar)
        self.statusbar = QtGui.QStatusBar(MainWindow)
        self.statusbar.setObjectName(_fromUtf8("statusbar"))
        MainWindow.setStatusBar(self.statusbar)

        self.retranslateUi(MainWindow)
        QtCore.QMetaObject.connectSlotsByName(MainWindow)

    def retranslateUi(self, MainWindow):
        MainWindow.setWindowTitle(_translate("MainWindow", "MainWindow", None))
        self.label.setText(_translate("MainWindow", "Command", None))
        self.btnAdd.setText(_translate("MainWindow", "Add", None))
        self.btnDelete.setText(_translate("MainWindow", "Delete", None))
        self.btnUp.setText(_translate("MainWindow", "Up", None))
        self.btnDown.setText(_translate("MainWindow", "Down", None))
        self.label_2.setText(_translate("MainWindow", "Instruction", None))
        self.closeInst.setText(_translate("MainWindow", " X", None))
        self.label_6.setText(_translate("MainWindow", "View", None))
        self.closeView.setText(_translate("MainWindow", " X", None))

