#!/bin/sh -eux

# Install pip
sudo apt-get install -y \
	aptitude \
	libssl-dev \
        libffi-dev \
	python-dev \
	python-pip

# Install ansible
pip install -U pip
pip install --user -U ansible

# Run the ansible playbooks
./run.sh -K "$@"
