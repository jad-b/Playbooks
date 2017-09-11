#!/bin/sh -eux

# Install pip
sudo apt-get install -y \
	aptitude \
	libssl-dev \
        libffi-dev \
	python-dev \
	python3-pip

# Install ansible
pip3 install -U pip
pip3 install --user -U ansible

# Run the ansible playbooks
./run.sh -K "$@"
