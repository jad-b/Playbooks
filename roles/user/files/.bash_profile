#!/bin/bash
# vim: filetype=sh
now() {
	date +%s%N
}
# Capture beginning of run time
start="$(now)"

time_since(){
	diff="$(($(date +%s%N)-$1))"
	# Drop nanoseconds through milliseconds (/10**9)
	seconds=$((diff/10**9))
	# Drop us to ns (/10**6), then truncate above ms (%10**3)
	ms=$((diff/10**6%10**3))
	printf "%d.%.3d seconds\n" ${seconds} ${ms}
}

print_pending() {
    # Display our tasks for the day.
    WAITING_FOR=~/Dropbox/Waiting-For.txt
    if hash pending 2>/dev/null && [[ -f "${WAITING_FOR}" ]]; then
        pending "${WAITING_FOR}" 2>/dev/null
    fi
}
# mkfifo tasks
print_pending
pending_pid=$!
# echo "print_pending job has pid of $pending_pid"

# Baseline my PATH
BASEPATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin:/snap/bin"
reset_path(){
    export PATH=${BASEPATH}
}; reset_path

export EDITOR=vim
export EMAIL="j.american.db@gmail.com"

pre_bashrc=$(now)
. ~/.bashrc
printf "Loaded .bashrc in %s\n" "$(time_since "$pre_bashrc")"

if [ -f ~/.bash_aliases ]; then
    pre_aliases=$(now)
    . ~/.bash_aliases
    printf "Loaded .bash_aliases in %s\n" "$(time_since "$pre_aliases")"
fi

# Local binaries
if [ -d ~/.local/bin ]; then
    export PATH="${HOME}/.local/bin:${PATH}"
fi

if [ -d "${HOME}/.local/opt" ]; then
	for path in ${HOME}/.local/opt/**/bin; do
		export PATH="${PATH}:$path"
	done
fi

# Chef
if hash chef 2>/dev/null; then
    eval "$(chef shell-init bash)"
fi

# Golang
if [ -d /usr/local/go ]; then
    export GOPATH="${HOME}"
    export GOMAXPROCS=$(nproc)
    export PATH="/usr/local/go/bin:${GOPATH}/bin:${PATH}"
fi

# Julia
JULIA_VERSION=0.6.0
JULIA_PATH="${HOME}/julia/${JULIA_VERSION}"
if [ -d "${JULIA_PATH}" ]; then
    export PATH="${JULIA_PATH}/bin:${PATH}"
fi

# Node & NPM
if hash npm 2>/dev/null; then
    NPM_PACKAGES="${HOME}/.npm-global"
    export PATH="${NPM_PACKAGES}/bin:${PATH}"
    unset MANPATH
    export MANPATH="${NPM_PACKAGES}/share/man:$(manpath)"
    export NODE_PATH="${NPM_PACKAGES}/lib/node_modules:${NODE_PATH}"
fi

# Python
export PYTHONDONTWRITEBYTECODE=true
# Pyenv
if hash pyenv 2>/dev/null; then
    export PYENV_ROOT="${HOME}/.pyenv"
    export PATH="${PYENV_ROOT}/bin:${PATH}"
    if [ -d "${PYENV_ROOT}" ]; then
        eval "$(pyenv init -)"
    fi
    if [ -d "${PYENV_ROOT}/plugins/pyenv-virtualenv" ]; then
        eval "$(pyenv virtualenv-init -)"
    fi
fi

# Python virtualenvwrapper
if hash virtualenv 2>/dev/null; then
    export WORKON_HOME=~/.venv
    export PROJECT_HOME=~/dev
fi

# Rust
if [ -d ~/.cargo ]; then
    export PATH="${HOME}/.cargo/bin:${PATH}"
fi

# Haskell
if hash stack 2>/dev/null; then
	eval "$(stack --bash-completion-script stack)"
fi

# Nix
NIX_DIR="${HOME}/.nix-profile/etc/profile.d/nix.sh"
if [ -d "${NIX_DIR}" ]; then
  . "${NIX_DIR}"
fi

# wait "$pending_pid"
# cat tasks
# ? How to close 'tasks'?


source_files=(
    ~/.secrets
    ~/.ocirc
    ~/.dockerrc
)

# Source all our files
for i in "${source_files[@]}"; do
    # echo "Sourcing $i ..."
    if [ -e "$i" ]; then
        # echo ">> Sourced $i"
        . "$i"
    fi
done

# Set default permissions
# User can do anything
# Group can read + execute
# Others can't do anything
umask 027
echo "Week $(date +%W)"
if [ -e /home/jdb/.nix-profile/etc/profile.d/nix.sh ]; then . /home/jdb/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
