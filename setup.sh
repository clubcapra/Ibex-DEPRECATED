git submodule init  
git submodule update
git submodule update --init --recursive
catkin_make
source devel/setup.bash

cwd="$PWD"
# Pour tous les packages rosjava
for i in src/capra_*; do
  if [ -e "$i/gradlew" ] && [ "$i" != "src/capra_msgs_java" ]; then
    cd $i
    git checkout master
    # Pour les sous-projets
    for j in *; do
        if [ -d "${j}" ]; then
          if [ -e "$j/build.gradle" ]; then
              cd $j
              ../gradlew deployApp
              cd ..
          fi
        fi
    done
    cd $cwd
  fi
done
