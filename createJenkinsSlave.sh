#!/bin/bash
set -e

JENKINS_VOLUME=${JENKINS_VOLUME:-jenkins-volume}
PROJECT_NAME=${PROJECT_NAME:-demo}
NEXUS_REPO=${NEXUS_REPO:-$1}

docker run \
--name ${PROJECT_NAME}-workspace \
openfrontier/jenkins-slave:maven \
echo "Jenkins workspace"

docker run \
--rm \
--volumes-from=${JENKINS_VOLUME}:ro \
--volumes-from=${PROJECT_NAME}-workspace \
openfrontier/jenkins-slave:maven \
jenkins-slave-setup.sh ${NEXUS_REPO}
