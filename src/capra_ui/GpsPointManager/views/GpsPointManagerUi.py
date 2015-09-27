# -*- coding: utf-8 -*-

# Form implementation generated from reading ui file 'views/GpsPointManager.ui'
#
# Created: Sun Sep 27 18:47:15 2015
#      by: PyQt4 UI code generator 4.10.4
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
        MainWindow.resize(800, 594)
        self.centralwidget = QtGui.QWidget(MainWindow)
        self.centralwidget.setObjectName(_fromUtf8("centralwidget"))
        self.listView_points = QtGui.QListView(self.centralwidget)
        self.listView_points.setGeometry(QtCore.QRect(10, 10, 271, 491))
        self.listView_points.setObjectName(_fromUtf8("listView_points"))
        self.pushButton_add = QtGui.QPushButton(self.centralwidget)
        self.pushButton_add.setGeometry(QtCore.QRect(10, 500, 41, 41))
        self.pushButton_add.setText(_fromUtf8(""))
        icon = QtGui.QIcon()
        icon.addPixmap(QtGui.QPixmap(_fromUtf8(":/images/images/add.png")), QtGui.QIcon.Normal, QtGui.QIcon.Off)
        self.pushButton_add.setIcon(icon)
        self.pushButton_add.setIconSize(QtCore.QSize(32, 32))
        self.pushButton_add.setObjectName(_fromUtf8("pushButton_add"))
        self.pushButton_delete = QtGui.QPushButton(self.centralwidget)
        self.pushButton_delete.setGeometry(QtCore.QRect(50, 500, 41, 41))
        self.pushButton_delete.setText(_fromUtf8(""))
        icon1 = QtGui.QIcon()
        icon1.addPixmap(QtGui.QPixmap(_fromUtf8(":/images/images/delete.png")), QtGui.QIcon.Normal, QtGui.QIcon.Off)
        self.pushButton_delete.setIcon(icon1)
        self.pushButton_delete.setIconSize(QtCore.QSize(32, 32))
        self.pushButton_delete.setObjectName(_fromUtf8("pushButton_delete"))
        self.frame_map = QtGui.QFrame(self.centralwidget)
        self.frame_map.setGeometry(QtCore.QRect(290, 10, 501, 341))
        self.frame_map.setFrameShape(QtGui.QFrame.StyledPanel)
        self.frame_map.setFrameShadow(QtGui.QFrame.Raised)
        self.frame_map.setObjectName(_fromUtf8("frame_map"))
        self.formLayoutWidget = QtGui.QWidget(self.centralwidget)
        self.formLayoutWidget.setGeometry(QtCore.QRect(300, 370, 221, 95))
        self.formLayoutWidget.setObjectName(_fromUtf8("formLayoutWidget"))
        self.formLayout = QtGui.QFormLayout(self.formLayoutWidget)
        self.formLayout.setFieldGrowthPolicy(QtGui.QFormLayout.AllNonFixedFieldsGrow)
        self.formLayout.setMargin(0)
        self.formLayout.setObjectName(_fromUtf8("formLayout"))
        self.label = QtGui.QLabel(self.formLayoutWidget)
        self.label.setObjectName(_fromUtf8("label"))
        self.formLayout.setWidget(0, QtGui.QFormLayout.LabelRole, self.label)
        self.lineEdit_id = QtGui.QLineEdit(self.formLayoutWidget)
        self.lineEdit_id.setObjectName(_fromUtf8("lineEdit_id"))
        self.formLayout.setWidget(0, QtGui.QFormLayout.FieldRole, self.lineEdit_id)
        self.label_2 = QtGui.QLabel(self.formLayoutWidget)
        self.label_2.setObjectName(_fromUtf8("label_2"))
        self.formLayout.setWidget(1, QtGui.QFormLayout.LabelRole, self.label_2)
        self.lineEdit_longitude = QtGui.QLineEdit(self.formLayoutWidget)
        self.lineEdit_longitude.setObjectName(_fromUtf8("lineEdit_longitude"))
        self.formLayout.setWidget(1, QtGui.QFormLayout.FieldRole, self.lineEdit_longitude)
        self.label_3 = QtGui.QLabel(self.formLayoutWidget)
        self.label_3.setObjectName(_fromUtf8("label_3"))
        self.formLayout.setWidget(2, QtGui.QFormLayout.LabelRole, self.label_3)
        self.lineEdit_latitude = QtGui.QLineEdit(self.formLayoutWidget)
        self.lineEdit_latitude.setObjectName(_fromUtf8("lineEdit_latitude"))
        self.formLayout.setWidget(2, QtGui.QFormLayout.FieldRole, self.lineEdit_latitude)
        MainWindow.setCentralWidget(self.centralwidget)
        self.menubar = QtGui.QMenuBar(MainWindow)
        self.menubar.setGeometry(QtCore.QRect(0, 0, 800, 25))
        self.menubar.setObjectName(_fromUtf8("menubar"))
        self.menuFile = QtGui.QMenu(self.menubar)
        self.menuFile.setObjectName(_fromUtf8("menuFile"))
        MainWindow.setMenuBar(self.menubar)
        self.statusbar = QtGui.QStatusBar(MainWindow)
        self.statusbar.setObjectName(_fromUtf8("statusbar"))
        MainWindow.setStatusBar(self.statusbar)
        self.actionImport = QtGui.QAction(MainWindow)
        self.actionImport.setShortcutContext(QtCore.Qt.WindowShortcut)
        self.actionImport.setObjectName(_fromUtf8("actionImport"))
        self.actionExport = QtGui.QAction(MainWindow)
        self.actionExport.setObjectName(_fromUtf8("actionExport"))
        self.menuFile.addAction(self.actionImport)
        self.menuFile.addAction(self.actionExport)
        self.menubar.addAction(self.menuFile.menuAction())

        self.retranslateUi(MainWindow)
        QtCore.QMetaObject.connectSlotsByName(MainWindow)

    def retranslateUi(self, MainWindow):
        MainWindow.setWindowTitle(_translate("MainWindow", "MainWindow", None))
        self.label.setText(_translate("MainWindow", "Identifier", None))
        self.label_2.setText(_translate("MainWindow", "Longitude", None))
        self.label_3.setText(_translate("MainWindow", "Latitude", None))
        self.menuFile.setTitle(_translate("MainWindow", "File", None))
        self.actionImport.setText(_translate("MainWindow", "Import ...", None))
        self.actionExport.setText(_translate("MainWindow", "Export ...", None))

import resources_rc
