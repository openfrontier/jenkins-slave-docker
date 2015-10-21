#!/bin/bash
set -e

JENKINS_SLAVE_IMAGE=${JENKINS_SLAVE_IMAGE:-openfrontier/jenkins-slave}
JENKINS_VOLUME=${JENKINS_VOLUME:-jenkins-volume}
PROJECT_NAME=${PROJECT_NAME:-demo}
NEXUS_REPO=${NEXUS_REPO:-$1}

docker run \
--name ${PROJECT_NAME}-workspace \
${JENKINS_SLAVE_IMAGE} \
echo "Jenkins workspace"

docker run \
--rm \
--volumes-from=${JENKINS_VOLUME}:ro \
--volumes-from=${PROJECT_NAME}-workspace \
${JENKINS_SLAVE_IMAGE} \
jenkins-slave-setup.sh ${NEXUS_REPO}
