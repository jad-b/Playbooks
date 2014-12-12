#!/bin/bash

ansible-playbook -i local --connection=local -K local.yml
