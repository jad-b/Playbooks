# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
set -P

# Auto-start tmux, if available
#if command -v tmux>/dev/null; then  # If tmux exists
#	if [[ ! $TERM =~ screen ]] && [ -z $TMUX ]; then
#		echo "Launching TMUX session '$USER'"
#		exec tmux
 #   else
#		echo "TMUX session detected"
#	fi
#fi

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

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

export EDITOR=vim

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# Enable extended globbing
shopt -s extglob

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# Disable scroll lock
stty -ixon


### Prompt coloring ###
export TERM=xterm-256color

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|xterm-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
# force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
    else
    color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
	if hash __docker_machine_ps1 2>/dev/null; then
		# Use the docker-machine prompt
		PS1='[\u@\h \[\033[01;34m\]\W\[\033[00m\]$(__docker_machine_ps1)]\$ '
	else
		## Full-color username@hostname:working dir$
		PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
	fi
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'

    # Show the currently running command in the terminal title:
    # http://www.davidpashley.com/articles/xterm-titles-with-bash.html
    show_command_in_title_bar() {
		# shellcheck disable=SC1001
        case "$BASH_COMMAND" in
            *\033]0*)
                # The command is trying to set the title bar as well;
                # this is most likely the execution of $PROMPT_COMMAND.
                # In any case nested escapes confuse the terminal, so don't
                # output them.
                ;;
            *)
                # echo -ne "\033]0;${USER}@${HOSTNAME}: ${BASH_COMMAND}\007"
                echo -ne "\033]0;${BASH_COMMAND}\007"
                ;;
        esac
    }
    trap show_command_in_title_bar DEBUG
    ;;
*)
    ;;
esac

# If this is an xterm set the title to user@host:dir
# case "$TERM" in
# xterm*|rxvt*)
#     PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
#     ;;
# *)
#     ;;
# esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    if [ -r ~/.dircolors ]; then
		eval "$(dircolors -b ~/.dircolors)"
	else
		eval "$(dircolors -b)"
	fi
	# shellcheck disable=SC2139
    alias ls="ls --color=auto --group-directories-first"
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias rgrep='rgrep --color=auto'
fi
### End prompt coloring ###

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

pre_aliases=$(now)
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
printf "Loaded .bash_aliases in %s\n" "$(time_since "$pre_aliases")"

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

export MYBIN="$HOME/.local/bin"
export PATH="$MYBIN:$PATH"

# Python virtualenvwrapper
export WORKON_HOME=~/.venv
export PROJECT_HOME=~/dev
export PYTHONDONTWRITEBYTECODE=true

# Pyenv
if hash pyenv 2>/dev/null; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    if [ -d "$PYENV_ROOT" ]; then
        eval "$(pyenv init -)"
    fi
    if [ -d "$PYENV_ROOT/plugins/pyenv-virtualenv" ]; then
        eval "$(pyenv virtualenv-init -)"
    fi
fi

# Node & NPM
NPM_PACKAGES="$HOME/.local/npm-packages"
export PATH="$NPM_PACKAGES/bin:$PATH"
unset MANPATH
export MANPATH="$NPM_PACKAGES/share/man:$(manpath)"
export NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"

# Golang
export PATH="/usr/local/go/bin:$PATH"
export GOPATH="$HOME/go"
export GOMAXPROCS=$(nproc)

# Haskell
if hash stack 2>/dev/null; then
	eval "$(stack --bash-completion-script stack)"
fi

# Julia
JULIA_PRO="$HOME/julia/JuliaPro-0.5.1.1"
if [ -d "$JULIA_PRO" ]; then
    export PATH="$PATH:$JULIA_PRO"
fi
JULIA_VERSION=0.6.0
export PATH="$HOME/julia/${JULIA_VERSION}/bin:$PATH"

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

###############################################################################
# CLI Completion Scripts
###############################################################################
pre_complete=$(now)
# Array of files within .completions
COMPLETIONS=(~/.completions/*)
source_files=(
    ~/.dynrc
    ~/.dockerrc
)

# Source all our files
for i in "${source_files[@]}" "${COMPLETIONS[@]}"; do
    # echo "Sourcing $i ..."
    if [ -e "$i" ]; then
        # echo ">> Sourced $i"
        . "$i"
    fi
done

# Google Cloud Platform
GCLOUD_SDK="$HOME/jdb/.local/google-cloud-sdk"
if [ -e "$GCLOUD_SDK" ]; then
	# The next line updates PATH for the Google Cloud SDK.
	source "$GCLOUD_SDK/path.bash.inc"

	# The next line enables shell command completion for gcloud.
	source "$GLOUC_SDK/completion.bash.inc"
fi

printf "Sourced completions in %s\n" "$(time_since "$pre_complete")"

# Kubernetes
if hash kubectl 2>/dev/null; then
	source <(kubectl completion bash)
fi

# Set default permissions
# User can do anything
# Group can read + execute
# Others can't do anything
umask 027

if [ -e ~/.secrets ]; then
	source ~/.secrets
fi

printf "Loaded .bashrc in %s\n" "$(time_since "$start")"

# added by Miniconda3 4.0.5 installer
# export PATH="/home/jdb/miniconda3/bin:$PATH"

###############################################################################
# Add binaries from .local
###############################################################################
if [ -d "$HOME/.local/opt" ]; then
	for path in $HOME/.local/opt/**/bin; do
		#echo "Adding $path to PATH"
		export PATH="$PATH:$path"
	done
fi
