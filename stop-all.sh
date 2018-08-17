#!/bin/bash

docker stop $(docker ps -aq)

docker ps