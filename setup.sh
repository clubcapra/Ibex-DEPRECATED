git submodule init  
git submodule update
git submodule update --init --recursive
catkin_make
source devel/setup.bash

cwd="$PWD"
for i in src/capra_*
do
  if [ -e "$i/gradlew" ] && [ "$i" != "src/capra_msgs_java" ]; then
    cd $i
    git checkout master
    ../gradlew deployApp
    cd $cwd
  fi
done
