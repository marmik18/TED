#!/bin/bash
DIR=$(dirname $(realpath $0))

docker run -it --rm --runtime nvidia --gpus all --net=host \
    --name point-cloud-pose-estimation-working-pillar-training \
    -v $DIR/../training/data:/root/OpenPCDet/data \
    -v $DIR/../training/build:/root/OpenPCDet/build \
    -v $DIR/../training/output:/root/OpenPCDet/output \
    -e PROTOCOL_BUFFERS_PYTHON_IMPLEMENTATION=python \
    wzl/point-cloud-pose-estimation-training:latest \
    cfgs/models/custom_models/TED-S-WORKING-PILLAR.yaml