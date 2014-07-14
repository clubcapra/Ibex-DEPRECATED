git submodule init  
git submodule update
git submodule update --init --recursive
catkin_make
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

