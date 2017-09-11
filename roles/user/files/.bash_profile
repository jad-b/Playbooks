#!/bin/bash
export EDITOR=vim

. ~/.bashrc

# Local binaries
if [ -d ~/.local/bin ]; then
    export PATH="~/.local/bin:$PATH"
fi

if [ -d "$HOME/.local/opt" ]; then
	for path in $HOME/.local/opt/**/bin; do
		#echo "Adding $path to PATH"
		export PATH="$PATH:$path"
	done
fi

# Rust
if hash cargo 2>/dev/null; then
    export PATH="$HOME/.cargo/bin:$PATH"
fi

# Python virtualenvwrapper
if hash virtualenv 2>/dev/null; then
    export WORKON_HOME=~/.venv
    export PROJECT_HOME=~/dev
fi
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
if hash npm 2>/dev/null; then
    NPM_PACKAGES="$HOME/.local/npm-packages"
    export PATH="$NPM_PACKAGES/bin:$PATH"
    unset MANPATH
    export MANPATH="$NPM_PACKAGES/share/man:$(manpath)"
    export NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"
fi

# Golang
if [ -d /usr/local/go ]; then
    export PATH="/usr/local/go/bin:$PATH"
    export GOPATH="$HOME/src"
    export GOMAXPROCS=$(nproc)
fi

# Haskell
if hash stack 2>/dev/null; then
	eval "$(stack --bash-completion-script stack)"
fi

# Julia
if [ -d "$JULIA_PRO" ]; then
    JULIA_PRO="$HOME/julia/JuliaPro-0.5.1.1"
    export PATH="$PATH:$JULIA_PRO"
fi
if hash julia 2>/dev/null; then
    JULIA_VERSION=0.6.0
    export PATH="$HOME/julia/${JULIA_VERSION}/bin:$PATH"
fi

# Chef
if hash chef 2>/dev/null; then
    eval "$(chef shell-init bash)"
fi
