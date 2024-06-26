#!/bin/bash

# PARAMETERS can be passed as environment variables 
if [[ -z "${IMAGE_NAME}" ]]; then
  IMAGE_NAME="wzl/point-cloud-pose-estimation-training"
fi
if [[ -z "${IMAGE_TAG}" ]]; then
  IMAGE_TAG=latest
fi

IMAGE="$IMAGE_NAME:$IMAGE_TAG"

if [[ -z "${DOCKER_USER}" ]]; then
  DOCKER_USER="rosuser"
fi
if [[ -z "${CONTAINER_NAME}" ]]; then
  CONTAINER_NAME="ted_container"
fi

# ---------------------------------------------------------------------------- #
#                                   RUN ARGS                                   #
# ---------------------------------------------------------------------------- #
if [[ -z "${DOCKER_RUN_ARGS}" ]]; then
  DOCKER_RUN_ARGS=()  # additional arguments for 'docker run'
else
  DOCKER_RUN_ARGS=(${DOCKER_RUN_ARGS})
fi

if [ "$(command -v nvidia-ctk)" ]; then
    DOCKER_RUN_ARGS+=("--runtime nvidia --gpus all")
fi

XSOCK=/tmp/.X11-unix
XAUTH=/tmp/.docker.xauth
touch $XAUTH
xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -

DOCKER_RUN_ARGS+=("--name ${CONTAINER_NAME}")
DOCKER_RUN_ARGS+=("--interactive")
DOCKER_RUN_ARGS+=("--tty")
DOCKER_RUN_ARGS+=("--net=host")
DOCKER_RUN_ARGS+=("--privileged")
DOCKER_RUN_ARGS+=("--rm")
DOCKER_RUN_ARGS+=("--volume `pwd`:/root/ws")
DOCKER_RUN_ARGS+=("--volume $XSOCK:$XSOCK:rw")
DOCKER_RUN_ARGS+=("--volume $XAUTH:$XAUTH:rw ")
DOCKER_RUN_ARGS+=("--env XAUTHORITY=${XAUTH}")
DOCKER_RUN_ARGS+=("--env DISPLAY=${DISPLAY}")

# if there is no container with the name 'ros_container'
if [ ! "$(docker ps -aq -f name=$CONTAINER_NAME)" ]; then
        echo "Starting container ..."
        echo "  Name: ${CONTAINER_NAME}"
        echo "  Image: ${IMAGE}"
        echo ""
        docker run  ${DOCKER_RUN_ARGS[@]} ${IMAGE} bash
elif [ "$(docker ps -aq -f name=$CONTAINER_NAME)" ]; then
    echo "==> Attaching to docker container ..."
    # attach shell to your container
    docker exec -it ${CONTAINER_NAME} bash 
fi 
