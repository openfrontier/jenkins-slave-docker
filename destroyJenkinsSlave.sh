#!/bin/bash

PROJECT_NAME=${PROJECT_NAME:-demo}

if [ -n "$(docker ps -a | grep ${PROJECT_NAME}-workspace)" ]; then
  docker rm -v ${PROJECT_NAME}-workspace
fi
