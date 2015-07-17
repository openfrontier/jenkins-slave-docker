FROM evarga/jenkins-slave

MAINTAINER zsx <thinkernel@gmail.com>

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    git \
  && rm -rf /var/lib/apt/lists/*

COPY maven.settings.xml /home/jenkins/settings.xml
