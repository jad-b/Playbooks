Playbooks
=========
Ansible playbook for setting up an Ubuntu development machine.

Current supported Ubuntu version = 16.04.3 (Xenial).

`./bootstrap.sh` installs Ansible and dependencies, and calls `./run.sh`

Use `./run.sh` to wrap the `ansible-playbook` command with required/good options in place.

## Manual Steps
* Set `tmux` to run on terminal open:
  * Check "login shell"
  * Check "use custom command": `tmux new-session -A -s jdb`

## Roles
`system` makes `sudo`-required changes, such as installing system packages and
installing Docker. (needs `-K` as a CLI flag).

`user` makes changes at the `$HOME/` and below-level, thus it should _not_ need
`sudo`.. Importantly, it symlinks in dotfiles.

`proglang` sets up various programming languages.

## Notes
The default user is `ansible_user`, which should be the user who's running `ansible-playbooks` (or `run.sh`).

## TODO
- Setup ~/.ghci & ~/.stack/config.yaml
- Haskell: `stack install hdevtools|haskell-docs`
- Symlink vim filetypes
- Switch to 'intel' gfx card: `sudo prime-select intel`
- Update display sclaing through `dconf`
  - [Ansible: dconf](http://docs.ansible.com/ansible/latest/dconf_module.html)
  - `gsetting list-keys com.ubuntu.user-interface`
- Run tpm/install_plugins
- Setup cron jobs for updating vim & tmux plugins.
- Setup cron job for running this playbook (monthly?)
- Download all personal git repos? Maybe overkill.
- Setup Apt [unattended-upgrades]
- Fix touchpad area through startup script
  - http://pappanyn.me/blog/2017/05/03/ubuntu-and-the-dell-xps-9560-touchpad/
- Add startup scripts
- Set gnome-terminal profile preferences

[unattended-upgrades]: https://linoxide.com/ubuntu-how-to/enable-disable-unattended-upgrades-ubuntu-16-04/
