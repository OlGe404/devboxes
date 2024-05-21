#!/bin/bash -e

# Install vagrant + packer as described in https://developer.hashicorp.com/vagrant/install
# and https://developer.hashicorp.com/packer/tutorials/docker-get-started/get-started-install-cli
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository -y "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt update && sudo apt install -y vagrant packer

# Install virtualbox as described in https://phoenixnap.com/kb/install-virtualbox-on-ubuntu
sudo apt install -y virtualbox virtualbox-ext-pack

# Install pip packages
python3 -m pip install -r requirements.txt

# Install ansible-collections
ansible-galaxy collection install -r requirements.yaml
