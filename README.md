Playbooks
=========
Ansible playbook for setting up an Ubuntu development machine.

Current supported Ubuntu version = 16.04.2 (Xenial).

`./bootstrap.sh` installs Ansible and dependencies, and calls `./run.sh`

Use `./run.sh` to wrap the `ansible-playbook` command with required/good options in place.

## Roles
`system` makes `sudo`-required changes, such as installing system packages and
installing Docker. (needs `-K` as a CLI flag).

`user` makes changes at the `$HOME/` and below-level, thus it should _not_ need
`sudo`.. Importantly, it symlinks in dotfiles.

`proglang` sets up various programming languages.

## Notes
The default user is `ansible_user`, which should be the user who's running
`ansible-playbooks` (or `run.sh`).

## TODO
- [ ] Setup cron jobs for updating vim & tmux plugins.
- [ ] Setup cron job for running this playbook (monthly?)
- [ ] Download all personal git repos? Maybe overkill.
