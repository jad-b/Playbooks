#!/bin/sh -eux

# Install pip
sudo  apt-get install -y \
	aptitude \
	libssl-dev \
        libffi-dev \
	python-dev \
	python3-pip

# Install ansible
pip3 install -U pip
# 20171124: 2.4.1  got hung while gathering facts
pip3 install --user -U ansible==2.4.0

# Run the ansible playbooks
./run.sh -K "$@"
