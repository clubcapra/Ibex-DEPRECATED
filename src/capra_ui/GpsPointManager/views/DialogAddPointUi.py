# -*- coding: utf-8 -*-

# Form implementation generated from reading ui file 'views/DialogAddPoint.ui'
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

class Ui_Dialog_add_point(object):
    def setupUi(self, Dialog_add_point):
        Dialog_add_point.setObjectName(_fromUtf8("Dialog_add_point"))
        Dialog_add_point.resize(263, 179)
        Dialog_add_point.setModal(True)
        self.buttonBox = QtGui.QDialogButtonBox(Dialog_add_point)
        self.buttonBox.setGeometry(QtCore.QRect(40, 130, 181, 32))
        self.buttonBox.setOrientation(QtCore.Qt.Horizontal)
        self.buttonBox.setStandardButtons(QtGui.QDialogButtonBox.Cancel|QtGui.QDialogButtonBox.Save)
        self.buttonBox.setCenterButtons(True)
        self.buttonBox.setObjectName(_fromUtf8("buttonBox"))
        self.formLayoutWidget = QtGui.QWidget(Dialog_add_point)
        self.formLayoutWidget.setGeometry(QtCore.QRect(20, 20, 221, 95))
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

        self.retranslateUi(Dialog_add_point)
        QtCore.QObject.connect(self.buttonBox, QtCore.SIGNAL(_fromUtf8("accepted()")), Dialog_add_point.accept)
        QtCore.QObject.connect(self.buttonBox, QtCore.SIGNAL(_fromUtf8("rejected()")), Dialog_add_point.reject)
        QtCore.QMetaObject.connectSlotsByName(Dialog_add_point)

    def retranslateUi(self, Dialog_add_point):
        Dialog_add_point.setWindowTitle(_translate("Dialog_add_point", "Add point", None))
        self.label.setText(_translate("Dialog_add_point", "Identifier", None))
        self.label_2.setText(_translate("Dialog_add_point", "Longitude", None))
        self.label_3.setText(_translate("Dialog_add_point", "Latitude", None))

