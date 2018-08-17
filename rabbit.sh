#!/bin/bash

CONTAINER_NAME='rabbit-dev'

ACTION='start'

if [ -n "$1" ]
then
    ACTION=$1
fi

echo 'Action: ' $ACTION;

if [ $ACTION = 'start' ]
then
    if [ "$(docker ps -q -f name=$CONTAINER_NAME)" ]
    then
        echo 'Already run'
    fi
    if [ "$(docker ps -q -f name=$CONTAINER_NAME -a)" ]
    then
        echo 'Start'
        docker start $CONTAINER_NAME
    else
        echo 'Run'
        docker \
            run \
            --detach \
            --hostname my-rabbit-dev \
            --name $CONTAINER_NAME \
            --publish 5672:5672 \
        rabbitmq;
    fi
fi

if [ $ACTION = 'stop' ]
then
    docker stop $CONTAINER_NAME
fi

docker ps