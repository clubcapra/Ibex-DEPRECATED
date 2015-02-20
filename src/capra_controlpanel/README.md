#Capra Controlpanel

ROS node to manage the hardware control panel of the robot. It can read data, like tension, current, temperature and button states, and activate or deactivate sensors. To add a sensor, its name must be added to the message (in /msg folder) and its name and ID(int defined on the board) must be added to the launchfile (in /launch). 

##ROS Integration

The node has a ROS service that accepts the /capra_controlpanel/set requests. These can be used to activate or deactivate sensors. A name(string) and a state (bool) must be provided. The request returns if the operation was successful or not.

The node also publishes on 2 topics:
* The /capra_controlpanel/analog_values uses RobotAnalogValues messages;
* The /capra_controlpanel/buttons uses RobotButtons messages.

The publish rate of these values and the serial port can be adjusted in the launch file.
