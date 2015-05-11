#!/bin/sh -e

# Install pip
sudo apt-get install python-pip python-dev

# Install ansible
pip install --user -U ansible

# Run the ansible playbooks
. run.sh
