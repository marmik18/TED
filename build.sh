#!/bin/bash

while getopts "fc" opt; do
    case $opt in
        f) REBUILD=true;;
        c) NOCACHE=true;;
        \?) 
          echo "Usage: $0 [-f] [-c]"
          echo "Options:"
          echo "-f To Rebuild Docker Image"
          echo "-c To No cache"
          exit 1;;
      esac
done

if [[ -z "${IMAGE_TAG}" ]]; then
  IMAGE_TAG=latest
fi

if [[ -z "${IMAGE_NAME}" ]]; then
  IMAGE_NAME=wzl/point-cloud-pose-estimation-training
fi

IMAGE="$IMAGE_NAME:$IMAGE_TAG"
# ---------------------------------------------------------------------------- #
#                               Docker Build Args                              #
# ---------------------------------------------------------------------------- #
if [[ -z "${DOCKER_BUILD_FILE}" ]]; then
  DOCKER_BUILD_FILE="docker/Dockerfile"
fi


if [[ -z "${DOCKER_BUILD_ARGS}" ]]; then
  DOCKER_BUILD_ARGS=()  # additional arguments for 'docker build'
else
  DOCKER_BUILD_ARGS=(${DOCKER_BUILD_ARGS})
fi

DOCKER_BUILD_ARGS+=("--file ${DOCKER_BUILD_FILE}")

if [[ "${NOCACHE}" ]]; then
  DOCKER_BUILD_ARGS+=("--no-cache")
fi

# ---------------------------------------------------------------------------- #
if [[ $REBUILD || "$(docker images -q ${IMAGE} 2> /dev/null)" == "" ]]; then
  echo "Building docker image ..."
  echo "  Name: ${IMAGE}"
  echo "  Dockerfile: ${DOCKER_BUILD_FILE}"
  echo "  Build Args: ${DOCKER_BUILD_ARGS[@]}"
  echo ""
  docker build -t ${IMAGE} ${DOCKER_BUILD_ARGS[@]} .
else
  echo "Image already exists: ${IMAGE}"
  echo "Please flag '-f' to force rebuild."
  echo "Please flag '-c' to use no cache."
fi
