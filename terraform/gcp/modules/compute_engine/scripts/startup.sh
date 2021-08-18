# source: https://cloud.google.com/compute/docs/instances/startup-scripts/linux#passing-local
#!/usr/bin/env bash

sudo apt-get update -y && \
sudo apt-get upgrade -y && \
sudo apt-get install -y vim \
                        nano \
                        python && \
sudo apt-add-repository ppa:ansible/ansible && \
sudo apt-get update -y && \
sudo apt-get install ansible -y
