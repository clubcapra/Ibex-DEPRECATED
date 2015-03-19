# Automatic install of Ibex for Capra. Please have Ibex at ~/Ibex for perfect results. Update the PATH script stuff if it's not the case.

IBEX_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

#install ROS
echo "Installing ROS..."

sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu trusty main" > /etc/apt/sources.list.d/ros-latest.list'
wget https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -O - | sudo apt-key add -
sudo apt-get update
sudo apt-get -y install ros-indigo-desktop-full ros-indigo-lms1xx ros-indigo-robot-pose-ekf ros-indigo-joy ros-indigo-nmea-* ros-indigo-move-base ros-indigo-map-server ros-indigo-hector-slam ros-indigo-gmapping ros-indigo-octomap-ros ros-indigo-octomap-rviz-plugins libgsl0-dev ros-indigo-laser-geometry ros-indigo-amcl ros-indigo-hector-gazebo ros-indigo-hector-gazebo-plugins ros-indigo-hector-sensors-gazebo ros-indigo-robot-localization

echo "Installing ROS done"

#seagoat dependencies
echo "Installing Seagoat Vision dependencies..."
sudo apt-get -y install python python-numpy python-scipy python-opencv python-protobuf
echo "Installing Seagoat Vision dependencies done."

#PATH and .bashrc stuff
echo "Setting up PATH and environment"

   #if not present, add it
if [ $(cat ~/.bashrc | grep Ibex | wc -l) -eq 0 ]; then
    echo "#ROS stuff
export IBEX_HOME=$IBEX_DIR
source /opt/ros/indigo/setup.bash
source \$IBEX_HOME/devel/setup.bash
export ROSCONSOLE_FORMAT='[\${severity}] [\${node}] [\${time}]: \${message}'
export GAZEBO_MODEL_PATH=$IBEX_DIR/src/capra_gazebo/models
export GAZEBO_RESOURCE_PATH=$IBEX_DIR/src/capra_gazebo/worlds
alias ibex='cd $IBEX_DIR'
alias apti='sudo apt-get install'" >> ~/.bashrc
fi
source /opt/ros/indigo/setup.bash
sudo cp $IBEX_DIR/install/49-capra.rules /etc/udev/rules.d/
sudo addgroup $USER dialout

echo "Updating PATH done"

#Rosdep
echo "Setting up rosdep..."
sudo rosdep init
rosdep update
echo "Setting up rosdep done"

#git config stuff
echo "Configuring git..."
git config --global fetch.recurseSubmodules true
git config --global alias.st status
git config --global alias.ci commit
git config --global alias.co checkout
git config --global alias.br branch
git config --global color.ui true
git config --global color.status auto
git config --global color.branch auto
git config --global color.diff true
echo "Configuring git done"

#git submodules
echo "Setting up submodules..."
git submodule init  
git submodule update --init --recursive
git submodule foreach git pull origin master
echo "Setting up submodules done."

#build workspace
echo "Building workspace..."
catkin_make
echo "Building workspace done"

#source workspace
source $IBEX_DIR/devel/setup.bash
cwd="$PWD"

echo "Ibex installed."
