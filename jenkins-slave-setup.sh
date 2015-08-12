#!/bin/bash
set -e

NEXUS_URL=$1

# Add Jenkins master's credential
mkdir -p /home/jenkins/.ssh
[ -f  /var/jenkins_home/.ssh/id_rsa.pub ] && \
    cat /var/jenkins_home/.ssh/id_rsa.pub >> /home/jenkins/.ssh/authorized_keys
chown -R jenkins:jenkins /home/jenkins/.ssh

# Setup nexus as proxy
if [ -n "${NEXUS_URL}" ] ; then
    mkdir -p /home/jenkins/.m2
    cat > /home/jenkins/.m2/settings.xml <<EOF
<settings xmlns="http://maven.apache.org/SETTINGS/1.1.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.1.0 http://maven.apache.org/xsd/settings-1.1.0.xsd">

  <mirrors>
    <mirror>
      <id>nexus</id>
      <name>Local Maven Repository Manager</name>
      <url>${NEXUS_URL}</url>
      <mirrorOf>*</mirrorOf>
    </mirror>
  </mirrors>
  <servers>
    <server>
      <id>deployment</id>
      <username>deployment</username>
      <password>deployment123</password>
    </server>
  </servers>
</settings>
EOF
    chown -R jenkins:jenkins /home/jenkins/.m2
fi
