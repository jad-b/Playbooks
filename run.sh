#!/bin/bash

# Pass *any* arguments into ansible-playbook with $@
ansible-playbook local.yml -i local --connection=local -K "$@"
