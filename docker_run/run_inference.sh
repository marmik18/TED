#!/bin/bash

XSOCK=/tmp/.X11-unix
XAUTH=/tmp/.docker.xauth
touch $XAUTH
xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -

docker run -it --rm --runtime nvidia --gpus all --net=host \
    -v `pwd`/data:/root/OpenPCDet/data \
    -v `pwd`/build:/root/OpenPCDet/build \
    -v `pwd`/ros2_ws:/root/ros2_ws \
    -v $XSOCK \
    -v $XAUTH \
    -e XAUTHORITY=$XAUTH \
    -e DISPLAY=$DISPLAY \
    --entrypoint /bin/bash \
    --privileged \
    wzl/point-cloud-pose-estimation-inference:latest