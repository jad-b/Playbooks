#!/bin/sh -e

# Install pip
sudo apt-get install python-pip

# Install ansible
sudo pip install ansible

# Run the ansible playbooks
./run.sh
