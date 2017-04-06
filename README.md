Playbooks
=========
Ansible playbook for setting up an Ubuntu development machine.

Current supported Ubuntu version = 16.04.2 (Xenial).

`./bootstrap.sh` installs Ansible and dependencies.

Use `./run.sh` to wrap the `ansible-playbook` command with required/good options in place.

## Roles
`system` makes `sudo`-required changes, such as installing system packages and
installing Docker.

`user` makes changes at the `$HOME/` and below-level. Importantly, it likes in
dotfiles.

`proglang` sets up various programming languages.

## Notes
The default user is `ansible_ssh_user`, which should be the user who's running
`ansible-playbooks` (or `run.sh`).

## TODO
- Setup cron jobs for updating vim & tmux plugins.
- Setup cron job for running this playbook (monthly?)
- Install gnome-terminal-solarized palette
- Download all personal git repos? Maybe overkill.
