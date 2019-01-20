#!/bin/bash

IMAGE_NAME=phpbb/php
CONTAINER_NAME=phpbb_php

echo "Cleaning..."

docker rm -v $CONTAINER_NAME
docker rmi $IMAGE_NAME

if [ "$OSTYPE" = "linux-gnu" ]; then
    U_ID=`id -u`
    G_ID=`id -g`
    BUILD_ARGS="--build-arg USER_ID=$U_ID --build-arg GROUP_ID=$G_ID"
else
    BUILD_ARGS=""
fi

echo "Build image $IMAGE_NAME with arguments: '$BUILD_ARGS'"

docker build -t $IMAGE_NAME $BUILD_ARGS .
