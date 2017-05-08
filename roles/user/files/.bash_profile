#!/bin/bash
. ~/.bashrc

# Configuration for pyenv
# export PATH="$HOME/.pyenv/bin:$PATH"
# eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"
if [ -f "$HOME/Documents/.dynrc" ]; then
	. "$HOME/Documents/.dynrc"
	echo "Sourced .dynrc"
fi


SSH_ENV="$HOME/.ssh/environment"

start_agent () {
    echo -n "Initialising new SSH agent..."
	# Store SSH environment variables from ssh-agent
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"  # Make readable
    . "${SSH_ENV}" > /dev/null  # Source env vars
    /usr/bin/ssh-add;  # Will prompt user for SSH key pasphrase
}

# Source SSH settings, if applicable
source_ssh () {
if [ -f "${SSH_ENV}" ]; then  # If environment file is found
    . "${SSH_ENV}" > /dev/null  # Source it.
	# Check if ssh-agent is running
    if ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null; then
		echo "SSH agent is already running"
	else
        start_agent;
    fi
else
    start_agent;
fi
}
