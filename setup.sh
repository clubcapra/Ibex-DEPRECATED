git submodule init  
git submodule update
catkin_make
source devel/setup.bash

cwd="$PWD"
for i in src/rosjava/capra_*
do
  cd $i
  ../gradlew deployApp
  cd $cwd
done
