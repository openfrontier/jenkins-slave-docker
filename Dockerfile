FROM openfrontier/jenkins-slave:maven

MAINTAINER zsx <thinkernel@gmail.com>

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    ruby \
  && rm -rf /var/lib/apt/lists/*

ENV SENCHA_HOME=/opt/Sencha
ENV SENCHA_CMD_VERSION=5.0.3.324
ENV SENCHA_CMD_HOME=${SENCHA_HOME}/Cmd/${SENCHA_CMD_VERSION}
ENV EXT_VERSION=5.0.1
ENV EXT_HOME=${SENCHA_HOME}/ext-${EXT_VERSION}

# Install sencha-cmd
RUN curl -o /cmd.run.zip http://cdn.sencha.com/cmd/${SENCHA_CMD_VERSION}/SenchaCmd-${SENCHA_CMD_VERSION}-linux-x64.run.zip && \
    unzip -p /cmd.run.zip > /cmd-install.run && \
    chmod +x /cmd-install.run && \
    /cmd-install.run --mode unattended --prefix /opt && \
    rm /cmd-install.run /cmd.run.zip

# Switch extjs codegen repo location
RUN sed -i "s#^repo.local.dir=.*#repo.local.dir=/home/jenkins/sencha-repo#g" ${SENCHA_CMD_HOME}/sencha.cfg

# Install extJS
RUN curl -o /ext-gpl.zip http://cdn.sencha.com/ext/gpl/ext-${EXT_VERSION}-gpl.zip && \
    unzip -q -d ${SENCHA_HOME} /ext-gpl.zip && \
    rm /ext-gpl.zip

# Add sencha-cmd to PATH
RUN echo "PATH=${SENCHA_CMD_HOME}:/usr/local/bin:/usr/bin:/bin" >> /etc/environment
