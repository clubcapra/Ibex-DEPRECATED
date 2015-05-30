git pull
git submodule init
git submodule update
git submodule foreach git checkout master
git submodule foreach git pull
cd src/navigation
git fetch
git co indigo-devel
git pull
