#!/bin/sh -eux

# Install pip
sudo apt-get install -y \
	aptitude \
	libssl-dev \
  libffi-dev \
	python-dev \
	python3-pip

# Upgrade pip3
pip3 install -U pip
# Install ansible
pip install --user -U cryptography ansible
