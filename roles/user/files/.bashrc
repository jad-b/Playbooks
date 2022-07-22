# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
# For Bash-specific configuration and enhancements
# For functions/aliases, see ~/.bash_aliases
# For modifying your terminal environment ($PATH, sourcing), see ~/.bash_profile

# set -u
set -P
set -o pipefail

# Auto-start tmux, if available
#if command -v tmux>/dev/null; then  # If tmux exists
#	if [[ ! $TERM =~ screen ]] && [ -z $TMUX ]; then
#		echo "Launching TMUX session '$USER'"
#		exec tmux
 #   else
#		echo "TMUX session detected"
#	fi
#fi

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

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

# Build an array of file fames
src_dirs=(~/src/*)
# export CDPATH=".:~/:/..:../.." # :$(echo ${src_dirs[*]// /:})"

### Prompt coloring ###
export TERM=xterm-256color

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|xterm-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

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
    ## Full-color username@hostname:working dir$
    # PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]\$ '
else
    # PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
    PS1='\u@\h \$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
#case "$TERM" in
#xterm*|rxvt*)
    #PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'

    ## Show the currently running command in the terminal title:
    ## http://www.davidpashley.com/articles/xterm-titles-with-bash.html
    #show_command_in_title_bar() {
		## shellcheck disable=SC1001
        #case "$BASH_COMMAND" in
            #*\033]0*)
                ## The command is trying to set the title bar as well;
                ## this is most likely the execution of $PROMPT_COMMAND.
                ## In any case nested escapes confuse the terminal, so don't
                ## output them.
                #;;
            #*)
                ## echo -ne "\033]0;${USER}@${HOSTNAME}: ${BASH_COMMAND}\007"
                #echo -ne "\033]0;${BASH_COMMAND}\007"
                #;;
        #esac
    #}
    #trap show_command_in_title_bar DEBUG
    #;;
#*)
    #;;
#esac

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

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# SSH Agent
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
  echo "starting ssh agent"
  ssh-agent > "$XDG_RUNTIME_DIR/ssh-agent.env"
  source "$XDG_RUNTIME_DIR/ssh-agent.env" # >/dev/null
  # Load SSH keys
  for key in ~/.ssh/*.key; do
    ssh-add ${key}
  done
fi
source "$XDG_RUNTIME_DIR/ssh-agent.env" # >/dev/null
