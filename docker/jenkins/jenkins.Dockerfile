# REVIEW VARIABLES LOADED AT BUILD-TIME
ARG JENKINS_VERSION

FROM jenkins/jenkins:${JENKINS_VERSION}-jdk11 AS base
USER root
RUN apt-get update -y && \
 apt-get install -y apt-transport-https \
       ca-certificates curl gnupg2 \
       software-properties-common
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN apt-key fingerprint 0EBFCD88
RUN add-apt-repository \
       "deb [arch=amd64] https://download.docker.com/linux/debian \
       $(lsb_release -cs) stable"
RUN apt-get update -y && \
    apt-get upgrade -y && \
    curl -fsSL get.docker.com | CHANNEL=stable sh && \
    apt-get install -y docker-ce-cli


FROM base AS etc

RUN usermod -aG sudo jenkins && \
    apt-get install -y net-tools \
                       sudo \
                       iputils-ping \
                       vim \
                       curl && \
    mkdir -p /usr/share/man/man1 && \
    apt-get update -y && \
    echo "jenkins  ALL=(ALL) NOPASSWD:ALL" | tee /etc/sudoers.d/jenkins

RUN curl -k https://download.docker.com/linux/static/stable/x86_64/docker-20.10.0.tgz \
    --output docker-20.10.0.tgz && \
    tar xvf docker-20.10.0.tgz && \
    mv docker /usr/local/bin/docker && \
    chown jenkins:jenkins /usr/local/bin/docker/docker

FROM etc AS final
COPY plugins2.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli -f /usr/share/jenkins/ref/plugins.txt
COPY ./casc-configs/jenkins.yaml /var/jenkins_home/casc_configs/jenkins.yaml

EXPOSE 22
USER jenkins
