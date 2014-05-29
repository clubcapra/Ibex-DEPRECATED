git submodule init  
git submodule update
#git submodule update --init --recursive
catkin_make
source devel/setup.bash

cwd="$PWD"
for i in src/rosjava/capra_*
do
  if [ "$i" != "src/rosjava/capra_msgs" ]; then
    cd $i
    ../gradlew deployApp
    cd $cwd
  fi
done
