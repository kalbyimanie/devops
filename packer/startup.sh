#!/bin/bash
sudo apt-get update -y && \

# install docker
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release -y && \

curl -fsSL get.docker.com | sh && \
sudo apt-get update -y && \
sudo apt-get install docker-ce docker-ce-cli containerd.io -y && \
sudo systemctl status docker
# end of install docker

# add new user
useradd -m -N -d /home/oie oie
# end add new user
