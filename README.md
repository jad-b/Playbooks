Playbooks
=========
Ansible playbook for setting up an Ubuntu development machine.

Current supported Ubuntu version = 16.04.3 (Xenial).

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
- Set gnome-terminal profile preferences using gconftool-2
- Install systemd service for [powertop](https://wiki.archlinux.org/index.php/Powertop#Apply_settings)
- Switch to 'intel' gfx card: `sudo prime-select intel`
- Run tpm/install_plugins
- Setup cron jobs for updating vim & tmux plugins.
- Setup cron job for running this playbook (monthly?)
- Setup Apt [unattended-upgrades]
- Fix touchpad area through startup script
  - http://pappanyn.me/blog/2017/05/03/ubuntu-and-the-dell-xps-9560-touchpad/
- Add startup scripts

[unattended-upgrades]: https://linoxide.com/ubuntu-how-to/enable-disable-unattended-upgrades-ubuntu-16-04/
