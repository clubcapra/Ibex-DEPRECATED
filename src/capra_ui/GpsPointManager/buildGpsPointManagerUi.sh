#!/bin/bash

echo "Start building GpsPointManager..."
echo ""

echo "Compiling Resources..."
pyrcc4 resources/resources.qrc -o views/resources_rc.py

echo "Building GpsPointManagerUi..."
pyuic4 views/GpsPointManager.ui -o views/GpsPointManagerUi.py

echo "Building DialogAddPointUi..."
pyuic4 views/DialogAddPoint.ui -o views/DialogAddPointUi.py

echo ""
echo "Done building GpsPointManager"