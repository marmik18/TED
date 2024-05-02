#!/bin/bash

IMAGE_NAME=wzl/point-cloud-pose-estimation-training
IMAGE_TAG=latest

IMAGE="$IMAGE_NAME:$IMAGE_TAG"
# ---------------------------------------------------------------------------- #
#                               Docker Build Args                              #
# ---------------------------------------------------------------------------- #
if [[ -z "${DOCKER_BUILD_FILE}" ]]; then
  DOCKER_BUILD_FILE="docker/Dockerfile.training"
fi

if [[ -z "${DOCKER_BUILD_ARGS}" ]]; then
  DOCKER_BUILD_ARGS=()  # additional arguments for 'docker build'
else
  DOCKER_BUILD_ARGS=(${DOCKER_BUILD_ARGS})
fi

DOCKER_BUILD_ARGS+=("$@ --file ${DOCKER_BUILD_FILE}")

# ---------------------------------------------------------------------------- #
echo "Building docker image ..."
echo "  Name: ${IMAGE}"
echo "  Build Args: ${DOCKER_BUILD_ARGS[@]}"
echo ""
docker build -t ${IMAGE} ${DOCKER_BUILD_ARGS[@]} .