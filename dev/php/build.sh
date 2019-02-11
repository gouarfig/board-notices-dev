#!/bin/bash

IMAGE_NAME=phpbb/php
IMAGE_VERSION=5.6
CONTAINER_NAME=phpbb_php

echo "Cleaning..."

docker rm -v ${CONTAINER_NAME}
# docker rmi ${IMAGE_NAME}:${IMAGE_VERSION}

if [ "$OSTYPE" = "linux-gnu" ]; then
    U_ID=`id -u`
    G_ID=`id -g`
    BUILD_ARGS="--build-arg USER_ID=${U_ID} --build-arg GROUP_ID=${G_ID}"
else
    BUILD_ARGS=""
fi

echo "Build image ${IMAGE_NAME} with arguments: '${BUILD_ARGS}'"

docker build --pull --tag ${IMAGE_NAME}:${IMAGE_VERSION} ${BUILD_ARGS} .
