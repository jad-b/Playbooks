#!/bin/bash -eux

# Pass *any* arguments into ansible-playbook with $@
ansible-playbook -v local.yml -i local --connection=local "$@"
