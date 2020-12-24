FROM ubuntu:21.04 AS base
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update -y

FROM base AS pkgs
RUN apt-get install -y openjdk-11-jre-headless \
                       openssh-server \
                       curl \
                       vim \
                       sudo \
                       net-tools

RUN curl https://download.docker.com/linux/static/stable/x86_64/docker-20.10.0.tgz \
    --output docker-20.10.0.tgz && \
    tar xvf docker-20.10.0.tgz && \
    mv docker /usr/local/bin/docker

FROM pkgs AS etc
ENV PATH="$PATH:/usr/local/bin/docker"
RUN adduser jenkins && \
    chown jenkins:jenkins /usr/local/bin/docker/docker && \
    ssh-keygen -A && \
    usermod -aG sudo jenkins && \
    mkdir -p /run/sshd && \
    chown -R jenkins:jenkins /home/jenkins
COPY .ssh_keys/id_rsa.pub /home/jenkins/.ssh/authorized_keys

RUN service ssh start
EXPOSE 22
CMD ["/usr/sbin/sshd","-D"]