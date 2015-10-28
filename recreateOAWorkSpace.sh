#!/bin/bash

set -e

PROJECT_NAME=oa
JENKINS_SLAVE_IMAGE=openfrontier/jenkins-slave:sencha
NEXUS_REPO=http://172.20.200.23/nexus/content/groups/public/

source ~/jenkins-slave-docker/destroyJenkinsSlave.sh
source ~/jenkins-slave-docker/createJenkinsSlave.sh
