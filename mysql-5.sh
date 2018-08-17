#!/bin/bash

CONTAINER_NAME='mysql-5.7-dev'
ROOT_PASSWORD='123456'

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
            --env MYSQL_ROOT_PASSWORD=$ROOT_PASSWORD \
            --env MYSQL_ROOT_HOST=% \
            --name $CONTAINER_NAME \
            --publish 3306:3306 \
        mysql:5.7;
    fi
fi

if [ $ACTION = 'stop' ]
then
    docker stop $CONTAINER_NAME
fi

docker ps