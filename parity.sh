#!/bin/bash

CONTAINER_NAME='eth-parity-dev'

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
            --name $CONTAINER_NAME \
            --publish 8545:8545 \
            -v $PWD/parity/:/root/.local/share/io.parity.ethereum/ \
            -ti \
            parity/parity:v1.7.0 \
            --rpcapi "eth,net,web3,personal,parity" \
            --chain kovan \
            --ui-interface all \
            --jsonrpc-interface all
            --base-path "/root/.local/share/io.parity.ethereum/";
    fi
fi

if [ $ACTION = 'stop' ]
then
    docker stop $CONTAINER_NAME
fi

docker ps