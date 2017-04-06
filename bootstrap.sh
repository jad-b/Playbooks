#!/bin/sh -eux

# Install pip
sudo apt-get install \
	aptitude \
	libssl-dev \
	python-dev \
	python-pip

# Install ansible
pip install --user -U ansible

# Run the ansible playbooks
./run.sh "$@"
