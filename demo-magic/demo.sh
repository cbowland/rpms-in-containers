#!/bin/bash

########################
# include the magic
#
# p    - print only, do not execute
# pe   - print and execute when enter is pressed
# pei  - print and execute immediately
# wait - wait until enter is pressed
# cmd  - interactive mode
#      - run commands behind the scenes, can be useful for hiding sensitive information
#
########################

########################
# $ ./my-demo.sh -h
# 
# Usage: ./my-demo.sh [options]
# 
#   Where options is one or more of:
#   -h  Prints Help text
#   -d  Debug mode. Disables simulated typing
#   -n  No wait
#   -w  Waits max the given amount of seconds before proceeding with demo (e.g. `-w5`)
########################

# set path to demo magic shell script
DEMO_MAGIC=../DemoMagic/demo-magic/demo-magic.sh

# source demo magic shell script
. $DEMO_MAGIC

# hide the evidence
clear

CONTAINER_REPO_URL=
CONTAINER_REPO_USER=
CONTAINER_REPO_PASSWORD=

# print title
p "Starting RPMs in Containers Demo"
yes '' | head -n3

# build apps
p "Build Hello World app"
p "take a look at the source"
pe "cat apps/hello.c"
# compile
pe "gcc -o apps/hello -x c apps/hello.c"
yes '' | head -n3

# run the hello world
pe "ls -l apps/"
p "run the app"
pe "apps/hello"
# build the hello world rpm
p "take a look at the rpm spec"
pe "cat rpm-work/hello-world.spec"
pe "rpmbuild --target "x86_64" -bb rpm-work/hello-world.spec"
yes '' | head -n3

#build fibonacci app
p "next app..."
p "take a look at the source"
pe "cat apps/fibonacci.c"
# compile
pe "gcc -o apps/fibonacci -x c apps/fibonacci.c"
# run
pe "ls -l apps/"
p "run the app"
pe "apps/fibonacci"
yes '' | head -n3
# build the rpm
p "take a look at the rpm spec"
pe "cat rpm-work/fibonacci.spec"
yes '' | head -n3
pe "rpmbuild --target "x86_64" -bb rpm-work/fibonacci.spec"
yes '' | head -n3

# copy rpms to correct spots on the file system
p "move the rpms inside this project"
pe "cp ~/rpmbuild/RPMS/x86_64/*.rpm ./rpm-work/"
pe "ls -l ./rpm-work"
yes '' | head -n3

# build container images
# use wrong base image as an example and talking point
pe "cat Containerfile-whoops"
yes '' | head -n3
pe "podman build -t fibonacci -f Containerfile-whoops"
yes '' | head -n3
pe "cat Containerfile-hello"
yes '' | head -n3
pe "podman build -t hello -f Containerfile-hello"
yes '' | head -n3
pe "cat Containerfile-fibonacci"
yes '' | head -n3
pe "podman build -t fibonacci -f Containerfile-fibonacci"
yes '' | head -n3
p "What the the difference between the whoops and the working container file?"
yes '' | head -n3
pe "diff Containerfile-whoops Containerfile-fibonacci"
yes '' | head -n3
p "notice the base image difference. dependencies matter!"
yes '' | head -n3
p "run the containers locally"
pe "podman run --rm hello"
yes '' | head -n3
pe "podman run --rm fibonacci"
yes '' | head -n3

# push to container repository
p "move the container image to a container image repository"
p "podman login $CONTAINER_REPO_URL -u $CONTAINER_REPO_USER -p THIS_IS_NOT_THE_PASSWORD"
podman login $CONTAINER_REPO_URL -u $CONTAINER_REPO_USER -p $CONTAINER_REPO_PASSWORD

p "push the fibonacci container to a container repository"
pe "podman push $CONTAINER_REPO_URL/$CONTAINER_REPO_USER/fibonacci"
yes '' | head -n3

p "run the container from the remote repository"
pe "podman run --rm quay.io/cbowland/fibonacci"
yes '' | head -n3
p 'time to deploy to openshift'