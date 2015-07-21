FROM maven:3-jdk-7

MAINTAINER zsx <thinkernel@gmail.com>

ENV JENKINS_HOME /home/jenkins

# Install a basic SSH server
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    openssh-server \
  && rm -rf /var/lib/apt/lists/*

RUN sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd
RUN mkdir -p /var/run/sshd

# Standard SSH port
EXPOSE 22

# Add user jenkins to the image
RUN useradd -m -d "${JENKINS_HOME}" -u 1000 -U -s /bin/bash jenkins
RUN echo "jenkins:jenkins" | chpasswd

VOLUME "${JENKINS_HOME}"

# Add setup script.
COPY jenkins-slave-setup.sh /usr/local/bin/jenkins-slave-setup.sh

# Start sshd by default.
CMD ["/usr/sbin/sshd", "-D"]
