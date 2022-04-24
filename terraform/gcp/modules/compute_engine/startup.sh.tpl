# source: https://cloud.google.com/compute/docs/instances/startup-scripts/linux#passing-local
#!/bin/bash

# install ansible
sudo apt-get update -yq && \
sudo apt-get install -yq vim \
                        nano \
                        curl \
                        wget \
                        gnupg \
                        python3 && \
sudo apt-add-repository ppa:ansible/ansible -y && \
sudo apt-get update -yq && \
sudo apt-get install ansible -yq

# end of install ansible

# install docker
sudo apt-get update -yq

sudo apt-get install -yq \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --yes --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update -yq

sudo apt-get install docker-ce docker-ce-cli containerd.io -yq

# end of install docker
