# Automatic install of Ibex for Capra. Please have Ibex at ~/Ibex for perfect results. Update the PATH script stuff if it's not the case.

allDone=0

abort()
{
	if [ $allDone -eq 0 ]
	then
	    echo "
=============================================
Error install Ibex. Aborting. 
Please check $logFile for details
=============================================" >&2
	fi
}

trap 'abort' 0 1 2 3 15

# flag to exit if a command causes an error
set -e

# request user and password
sudo echo ""

# setup logfile
logFile="logsetup.log"

echo "=============================================================
Installing Ibex...
The process may take a while. If you're worried something 
went wrong, juste check the logs ($logFile)
============================================================="

IBEX_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
BASHRC=~/.bashrc

#install ROS
echo "Downloading packages..."
{
	sudo sh -c '. /etc/lsb-release && echo "deb http://mirror.umd.edu/packages.ros.org/ros/ubuntu $DISTRIB_CODENAME main" > /etc/apt/sources.list.d/ros-latest.list'	
	wget https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o $logFile -O - | sudo apt-key add - 
	sudo apt-get update 
	sudo apt-get -y install ros-indigo-desktop-full ros-indigo-lms1xx ros-indigo-robot-pose-ekf ros-indigo-joy ros-indigo-nmea-* ros-indigo-move-base ros-indigo-map-server ros-indigo-hector-slam ros-indigo-gmapping ros-indigo-octomap-ros ros-indigo-octomap-rviz-plugins libgsl0-dev ros-indigo-laser-geometry ros-indigo-amcl ros-indigo-hector-gazebo ros-indigo-hector-gazebo-plugins ros-indigo-hector-sensors-gazebo ros-indigo-robot-localization gitk libjpeg62 libtiff4-dev gir1.2-gtksource-3.0 ros-indigo-prosilica-camera ros-indigo-dwa-local-planner ros-indigo-teleop-twist-keyboard

	sudo apt-get -y install python python-numpy python-scipy python-opencv python-protobuf 

} >> $logFile 

#PATH and .bashrc stuff
echo "Setting up ROS PATH and environment"
{
	#Add ROS stuff in .bashrc
	ROS_BORDER_BEGIN='#ROS stuff BEGIN'
        ROS_BORDER_END='#ROS stuff END'

        if [[   $(cat "$BASHRC" | grep "$ROS_BORDER_BEGIN" | wc -l) -eq 1 &&
                $(cat "$BASHRC" | grep "$ROS_BORDER_END" | wc -l) -eq 1 ]]
        then
            echo "[INFO] - Deleting old configs in $BASHRC"
            sed -i '/#ROS stuff BEGIN/,/#ROS stuff END/d' $BASHRC
        elif [[ $(cat "$BASHRC" | grep Ibex | wc -l) -gt 0 ]]; then
            echo "[ERROR] - Your .bashrc is old. You must remove all yout ROS config in .bashrc manually then re-run this script to continue. Exiting..."
            exit 2
        fi

        echo "[INFO] - Setting latest configs in $BASHRC"
        echo "#ROS stuff BEGIN
        export IBEX_HOME=$IBEX_DIR
        source /opt/ros/indigo/setup.bash
        source \$IBEX_HOME/devel/setup.bash
        export ROSCONSOLE_FORMAT='[\${severity}] [\${node}] [\${time}]: \${message}'
        export GAZEBO_MODEL_PATH=\$IBEX_HOME/src/capra_gazebo/models
        export GAZEBO_RESOURCE_PATH=\$IBEX_HOME/src/capra_gazebo/worlds
        alias ibex='cd \$IBEX_HOME'
        alias apti='sudo apt-get install'
#ROS stuff END" >> $BASHRC

	source /opt/ros/indigo/setup.bash
	sudo cp $IBEX_DIR/install/49-capra.rules /etc/udev/rules.d/
	sudo addgroup $USER dialout

	#Rosdep
	if [ -f "/etc/ros/rosdep/sources.list.d/20-default.list" ]
	then
		echo "Rosdep seems to be already there. Skipping.. "
	else
		sudo rosdep init
		rosdep update
	fi

} >> $logFile 


#git config stuff
echo "Configuring and setting up git and submodules..."
{
	git config --global fetch.recurseSubmodules true
	git config --global alias.st status
	git config --global alias.ci commit
	git config --global alias.co checkout
	git config --global alias.br branch
	git config --global color.ui true
	git config --global color.status auto
	git config --global color.branch auto
	git config --global color.diff true

	git submodule init  
	git submodule update --init --recursive
	git submodule foreach git pull origin master

	pushd src/navigation/ 2>&1
	git checkout indigo-devel 
	popd 2>&1
} >> $logFile 

#build workspace
echo "Building workspace... This can take a while"
catkin_make >> $logFile 

#source workspace
source $IBEX_DIR/devel/setup.bash
cwd="$PWD"

echo "
=========================================================
Ibex installation successful. Grab a beer and a pizza!
========================================================="

echo "You can now run 'roslaunch launch/simulation/sim_exemple.launch' from the Ibex folder"

allDone=1

exit
