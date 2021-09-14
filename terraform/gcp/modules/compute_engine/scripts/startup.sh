# source: https://cloud.google.com/compute/docs/instances/startup-scripts/linux#passing-local
#!/usr/bin/env bash


# install ansible
sudo apt-get update -y && \
sudo apt-get upgrade -y && \
sudo apt-get install -y vim \
                        nano \
                        python && \
sudo apt-add-repository ppa:ansible/ansible && \
sudo apt-get update -y && \
sudo apt-get install ansible -y

# end of install ansible

# install docker
sudo apt-get update -y

 sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update -y

sudo apt-get install docker-ce docker-ce-cli containerd.io -y

# end of install docker
