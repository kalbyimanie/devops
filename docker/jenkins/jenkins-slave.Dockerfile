FROM ubuntu:24.04 AS base
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update -y

FROM base AS pkgs
RUN apt-get install -y openjdk-17-jre-headless \
                       openssh-server \
                       curl \
                       vim \
                       sudo \
                       bash \
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
    chown -R jenkins:jenkins /home/jenkins && \
    apt-get install -y git && \
    chown jenkins:jenkins /usr/bin/git && \
    mkdir -p /home/jenkins/.ssh && \
    ssh-keyscan -H github.com >> /home/jenkins/.ssh/known_hosts

# COPY .ssh_keys/id_rsa.pub /home/jenkins/.ssh/authorized_keys
# COPY .ssh_keys/id_rsa.pub /home/jenkins/.ssh/id_rsa.pub
# COPY .ssh_keys/id_rsa /home/jenkins/.ssh/id_rsa
# COPY ssh-config/sshd_config /etc/ssh/sshd_config

RUN chown -R jenkins:jenkins /home/jenkins

FROM etc AS misc
# install go
ENV GO_VERSION=1.21.3
RUN curl -LO https://go.dev/dl/go$GO_VERSION.linux-amd64.tar.gz && tar -C /usr/local -xzf go$GO_VERSION.linux-amd64.tar.gz
ENV PATH="$PATH:/usr/local/go/bin"

# install nodejs
ENV NODEJS_VERSION=21.0.0
RUN curl -LO https://nodejs.org/download/release/v$NODEJS_VERSION/node-v$NODEJS_VERSION-linux-arm64.tar.gz && tar -xvf node-v$NODEJS_VERSION-linux-arm64.tar.gz -C /usr/local
ENV PATH="$PATH:/usr/local/node-v21.0.0-linux-arm64/bin"

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
