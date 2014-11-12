git submodule init  
git submodule update
git submodule update --init --recursive
catkin_make
source devel/setup.bash

cwd="$PWD"

#git config stuff
git config --global fetch.recurseSubmodules true
git config --global alias.st status
git config --global alias.ci commit
git config --global alias.co checkout
git config --global alias.br branch
git config --global color.ui true
git config --global color.status auto
git config --global color.branch auto
git config --global color.diff true

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

