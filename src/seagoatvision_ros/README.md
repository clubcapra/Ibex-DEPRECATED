# ROS doc

### Subscribed topics
#### image_input ([sensor_msgs/Image](http://docs.ros.org/api/sensor_msgs/html/msg/Image.html))
Incoming raw image to apply filters on. Can be modified with the image_input parameter.

### Published topics
#### image_filtered ([sensor_msgs/Image](http://docs.ros.org/api/sensor_msgs/html/msg/Image.html))
Output image after the filters have been applied. Can be modified with the ~image_output parameter.

### Services
~show_gui (std_srvs/Empty)<br/>
Shows the Seagoat GUI.

### Parameters
~filterchain (string, required)<br/>
Path of the filterchain to load

~gui (bool, default: False)<br/>
Whether or not to show the GUI of the application

~timeout (float, default:1.0) <br/>
Time to wait for an input image

~image_input (string, default: ~image_input) <br/>
Topic on which to listen for images

~image_output<br/> (string, default: ~image_filtered)
Topic on which to send the filtered images

# Seagoat doc

This Vision Server is tested on OpenCV 2.4.2 and Python 2.7 on Fedora 17 and Ubuntu 12.04.

Requirements:
 - Python 2.7
 - PyQt4
 - Glade 3
 - OpenCV 2.4 w/ Python/Numpy bindings
 - Numpy
 - Scipy

==== INSTALLATION ====

A. Install dependencies

  Ubuntu :

    Execution only :
 sudo apt-get install python python-numpy python-scipy python-opencv python-protobuf protobuf

  Fedora : 

    Execution only :
 sudo apt-get install python numpy scipy opencv-python protobuf-python protobuf

  Windows :
	Install the following dependencies :
 - Python: 	http://python.org/ftp/python/2.7.3/python-2.7.3.msi
 - Numpy: 	http://sourceforge.net/projects/numpy/files/NumPy/	# Choose the installer
 - Scipy:	http://sourceforge.net/projects/scipy/files/scipy/	# Choose the installer
 - PyQt4:	http://www.riverbankcomputing.co.uk/software/pyqt/download
 - PySide: 	http://qt-project.org/wiki/PySide_Binaries_Windows
 - PIL:		http://effbot.org/downloads/PIL-1.1.7.win32-py2.7.exe
 - OpenCV: 	http://www.lfd.uci.edu/~gohlke/pythonlibs/#opencv	# OpenCV installer for Windows.

 More information on OpenCV is available here: http://opencv.willowgarage.com/wiki/InstallGuide

