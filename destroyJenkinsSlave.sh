#!/bin/bash

PROJECT_NAME=${PROJECT_NAME:-demo}

docker rm -v ${PROJECT_NAME}-workspace
