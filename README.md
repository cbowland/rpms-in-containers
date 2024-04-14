# rpms-in-containers

# install dependencies
sudo dnf install -y rpmdevtools git gcc podman runc
rpmdev-setuptree


# set up directories
mkdir ~/workspace/DemoMagic
cd ~/workspace/DemoMagic

# clone demo magic script
https://github.com/paxtonhare/demo-magic.git

# get source code
cd ..
git clone https://github.com/cbowland/rpms-in-containers.git
cd rpms-in-container

# build apps
gcc -o apps/hello -x c apps/hello.c
# run
apps/hello
# build the rpm
rpmbuild --target "x86_64" -bb rpm-work/hello-world.spec

# compile
gcc -o apps/fibonacci -x c apps/fibonacci.c
# run
app/fibonacci
# build the rpm
rpmbuild --target "x86_64" -bb rpm-work/fibonacci.spec

# copy rpms to correct spots on the file system
cp ~/rpmbuild/RPMS/x86_64/*.rpm ./rpm-work/

# build container images
# use wrong base image as an example and talking point
podman build -t fibonacci -f kubernetes/Containerfile-whoops
podman build -t hello -f kubernetes/Containerfile-hello
podman build -t fibonacci -f kubernetes/Containerfile-fibonacci