#!/bin/bash

CONTAINER_NAME='pgsql-dev'
PASSWORD='123456'
USERNAME='postgres'

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
            --env POSTGRES_PASSWORD=$PASSWORD \
            --env POSTGRES_USER=$USERNAME \
            --name $CONTAINER_NAME \
            --publish 5432:5432 \
        postgres;
    fi
fi

if [ $ACTION = 'stop' ]
then
    docker stop $CONTAINER_NAME
fi

docker ps