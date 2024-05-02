#!/bin/bash

DIR=$(dirname $(realpath $0))
ROS_DOMAIN_ID=30
RMW_IMPLEMENTATION="rmw_cyclonedds_cpp"

docker run -it --rm --runtime nvidia --gpus all --net=host \
    -v $DIR/../training/build:/root/OpenPCDet/build \
    -v $DIR/../training/output:/root/OpenPCDet/output \
    -e ROS_DOMAIN_ID=$ROS_DOMAIN_ID \
    -e RMW_IMPLEMENTATION=$RMW_IMPLEMENTATION \
    wzl/point-cloud-pose-estimation-inference:latest \
    working_pillar.launch.py