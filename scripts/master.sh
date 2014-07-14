export ROS_IP=192.168.1.10
sudo ifconfig wlan0 192.168.1.10 netmask 255.255.255.0 up
roslaunch $(rospack find capra_2dnav)/launch/capra_configuration.launch outdoor:=0
