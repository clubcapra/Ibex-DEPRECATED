# Automatic install of Ibex for Capra. Please have Ibex at ~/Ibex for perfect results. Update the PATH script stuff if it's not the case.


#install ROS
echo "Installing ROS..."

sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu trusty main" > /etc/apt/sources.list.d/ros-latest.list'
wget https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -O - | sudo apt-key add -
sudo apt-get update
sudo apt-get install ros-indigo-desktop-full ros-indigo-lms1xx ros-indigo-robot-pose-ekf ros-indigo-joy ros-indigo-nmea-* ros-indigo-move-base ros-indigo-map-server ros-indigo-hector-slam ros-indigo-gmapping ros-indigo-octomap-ros ros-indigo-octomap-rviz-plugins libgsl0-dev ros-indigo-laser-geometry

echo "Installing ROS done"

#PATH and .bashrc stuff
echo "Updating PATH..."

   #if not present, add it
if [ $(cat ~/.bashrc | grep Ibex | wc -l) -eq 0 ]; then
    echo "#ROS stuff" >> ~/.bashrc
    echo "export IBEX_HOME=~/Ibex" >> ~/.bashrc
    echo "source /opt/ros/indigo/setup.bash" >> ~/.bashrc
    echo "source \$IBEX_HOME/devel/setup.bash" >> ~/.bashrc
    echo "export ROSCONSOLE_FORMAT='[\${severity}] [\${node}] [\${time}]: \${message}'" >> ~/.bashrc
fi


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
source devel/setup.bash

cwd="$PWD"


#for i in `grep path .gitmodules | sed 's/.*= //'`; do
#    cd $i
##    git checkout master
#    # Si c'est un package rosjava
#    if [ -e "gradlew" ]; then
#        # Pour tous les sous-projets
#        for j in *; do
#            if [ -d "${j}" ]; then
#                if [ -e "$j/build.gradle" ] && [ "$j" != "capra_msgs" ]; then
#                    cd $j
#                    echo $j
#                    ../gradlew deployApp
#                    cd ..
#                fi
#            fi
#        done
#    fi
#    cd $cwd
#done

