#!/bin/bash -e
# vim: filetype=sh

alias rals='. ~/.bash_aliases'
alias rebash='. ~/.bash_profile'

# System aliases
# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias sctl=`systemctl`

# *Always* ignore some directories
alias rgrep='rgrep --exclude-dir=.git --exclude-dir=.berkshelf --exclude-dir=Godeps --exclude-dir=.kitchen'

# Usage: cat file.txt | xclipd
alias xclipd='xclip -selection clipboard'

detectGoPkg() {
	local gosrc=$HOME/go/src/
	if [[ $PWD == $gosrc* ]]; then
		export GOPKG=${PWD#$gosrc}
		# echo "GOPKG=${PWD#$gosrc}"
	else
		unset GOPKG
		# echo "Unsetting GOPKG"
	fi
}

cd() {
	builtin cd "$@"
    if [ -n TMUX ]; then
        path=${*%*/} # Remove trailing slash
        #tmux rename-window "${path##*/}" # Remove everything through last slash
    fi
	detectGoPkg
}

joinString() {
	local IFS="$1"
	shift
	printf "%s" "$*"
}

# Grep within specific files.
findgrep() {
    find . -name "$1" -exec grep -H "$2" {} \;
}


###############################################################################
# Map, in bash!
#
# Usage:
#     map <command> -- [<argument>...]
#
# Example:
#     map dig +short -- $(allbox prod ussnn1 | tr '\n' ' ')
###############################################################################
map(){
	local delim='--'
	local hosts=""
	local cmd=""
	local switch=1
	for (( i=1; i<=$#; i++ )); do
		if [[ "${!i}" = "${delim}" ]]; then
			switch=0
			continue
		fi
		if (( "$switch" )); then
			# printf "Found '%s' at index %d\n" "${!i}" "$i"
			hosts="$hosts ${!i}"
		else
			cmd="$cmd ${!i}"
		fi
	done
	# printf "Running on these hosts:\n\t %s\n"  "$hosts"
	for h in $hosts; do
		printf "%s\n\t %s\n" "$h" "$(eval  "$cmd $h")"
	done
}

###############################################################################
                                # Networking #
###############################################################################
# Print the (hostname,ens3 IPv4 address) tuple for the given interface.
inet_addrs() {
    local IFACE=$1
    local HOST=$2
    ssh -T $HOST <<-EOH
    /usr/sbin/ip addr show $IFACE | \
        grep 'inet\b' | \
        awk '{print \$2}' | \
        cut -d/ -f1
EOH
}

wifictl (){
	case "$1" in
		on)
			nmcli nm wifi on
			;;
		off)
			nmcli nm wifi off
			;;
		flap)
			nmcli nm wifi off && nmcli nm wifi on
			;;
	esac
}

# Important variable exports
dotfiles=(
	'.dockerrc'
	'.inputrc'
    '.bash_aliases'
    '.bashrc'
    #'.gitconfig'
    '.profile'
    '.tmux.conf'
    '.vimrc'
)
# Prefix with absolute path
export DOTFILES=( "${dotfiles[@]/#/$HOME/}" )

getconf(){
    # Retrieve all *rc files from the home directory
    find "$HOME" -maxdepth 0 -regex '.[^.]*' -printf '%P\n'
}

updots(){
    # Upload some essential dotfiles to the remote server
    # Prefix files with '$HOME/'
	HOST="$1"
	REMOTE_USER="${2:-jdobbinsbucklad}"
    DEST=/home/"$REMOTE_USER"/
    echo "Uploading ${DOTFILES[@]} to $REMOTE_USER@$HOST:$DEST"
    rsync -avzL "${DOTFILES[@]}" "$REMOTE_USER@$HOST:$DEST"
	# Setup TPM
	echo "Setting up TMUX Plugin manager"
	local tpm_dir="$REMOTE_USER/.tmux/plugins/"
	ssh "$REMOTE_USER@$HOST" mkdir -p $tpm_dir
	rsync -avz ~/.tmux/plugins/tpm "$REMOTE_USER@$HOST:$tpm_dir"
	# This has become a *lot* of files:
	# rsync -avz ~/.vim "$REMOTE_USER@$HOST:$DEST"
}

# Pulls out the version from a string
whatver(){
	sed -s -n 's/^.*\([0-9]\+\.[0-9]\+\.[0-9]\+\).*$/\1/p' <<< "$1"
}

mine(){
    sudo chown -R jdb:jdb "${1:-.}"
}

yours() {
	set -u
	sudo chown -R "$1": "${2:-.}"
	set +u
}

###############################################################################
# Kill all listed tmux sessions
###############################################################################
tmux-kill(){
    for i in "$@"; do
        echo "Killing session $i..."
        tmux kill-session -t "$i"
    done
}

###############################################################################
# Run given command on changes.
###############################################################################
poll(){
    local FORMAT=$(echo -e "\033[1;33m%w%f\033[0m written")
    while inotifywait -qre close_write --format "$FORMAT" .; do
        eval "$@" || true
    done
}

###############################################################################
# Swap two filenames in place.
#
# Globals:
#   None
# Arguments:
#   Name of first file
#   Name of second file
# Returns:
#   None
###############################################################################
swap() {
    local TMPFILE=tmp.$$    # '$$' is the process ID; creates unique filename
    mv "$1" $TMPFILE
    mv "$2" "$1"
    mv $TMPFILE "$2"
}

###############################################################################
# Print latest file in given or current directory
#
# Arguments:
#   Directory to retrieve latest file from.
###############################################################################
latest(){
    SEARCH_PATH=${1:-.}
    find "$SEARCH_PATH" -maxdepth 1 -type f -printf '%T+ %p\n' | sort -r | head -n1 | awk '{print $2}'

}

###############################################################################
# Change to a new project
#
# Searches for a directory within a preset array of source code directories.
#
# Arguments:
#   PROJECT: Name of project directory.
###############################################################################
work() {
	local PROJECT="$1"
    # Where your code|projects live
    local DEV_DIRS=(
		"$HOME/src/"
		"$(pwd)"
        "$HOME"
	)
    # Change to the first matching directory
	# shellcheck disable=SC2086
    local WORK_DIR="$(
        find "${DEV_DIRS[@]}" -maxdepth 3 -name $PROJECT 2>/dev/null \
            | sort \
            | head -n 1
    )"
	if [[ -z ${WORK_DIR// } ]]; then
		echo "$PROJECT not found"
		return 1
	fi
    echo "Changing to $WORK_DIR"
    cd "$WORK_DIR"
	# tmux rename-window "$PROJECT"
}

###############################################################################
# Open a file for writing
#
# TODO(2017Feb24,jdb):
#   - Case-insensitive search
#   - Fuzzy string matching using heuristics and edit distance
#
# Arguments:
#   FILENAME: Name of file to open.
#   DIRECTORY: Parent directory to search within.
###############################################################################
pen() {
	local FILENAME=${1}
	local DIRECTORY=${1:-.}

}

###############################################################################
# List the ten largest file/directories
#
# Globals:
#   None
# Arguments:
#   Directory to search
# Returns:
#   Descending list of ten largest files/directories
###############################################################################
top10(){
    sudo du -hx "${1:-.}" | sort -rh | head -10
}

# Make a copy of a file with the timestamp suffixed
stamp(){
    cp "${1}" "${1}.$(date -u +'%Y%m%d')"
}

norig(){ find -name '*.orig' -delete; }

# Print out the date in the only logical way: YearMonthDay
dateme(){
	date +"%Y%b%d"
}


###############################################################################
# Creates a Jekyll-accepted post file.
###############################################################################
jpost(){
    BLOGDIR="$HOME/Dropbox/dev/most_resistance/categories"
    DIRPATH="$BLOGDIR/$CATEGORY/_posts"
	# Display help message
    if [ $# -eq 0 ]; then
		cat <<EOF
Usage:
	jpost <category> <post name with spaces>

	Available categories:
	$(find "$BLOGDIR" -type f -maxdepth=1 | tr '\n' ' ')
EOF
        return 0
    fi

    # Extract target category
    CATEGORY="$1"
    shift 1

    # Put hyphens in the title
    HYPHENATED_TITLE="$(echo "$@" | tr ' ' '-')"
    FILENAME="$(date +%F)-$HYPHENATED_TITLE.md"
    echo "Creating $CATEGORY/$FILENAME"

    if [ ! -d "$DIRPATH" ]; then  # Create the thing.
        # Create category &| _posts dir
        mkdir -p "$DIRPATH"
        # Stream and modify our new category's index.html
        sed  's/^category: \w\+$/category: '"$CATEGORY"'/g' \
            "$BLOGDIR/programming/index.html" > "$BLOGDIR/$CATEGORY/index.html"
    fi
    FILEPATH="$DIRPATH/$FILENAME"
    cat > "$FILEPATH" <<EOF
---
layout: page
title: $@
category: $CATEGORY
---
EOF
    # Open file in vim
    vim "$FILEPATH"
}


# Make mount command output pretty and human readable format
alias mount='mount |column -t'


###############################################################################
# Display a directory tree
#
# Arguments
#   1: Root directory of the tree
#   @:1) Arguments to 'tree'
###############################################################################
treed(){
	tree -d  "${@:2}" "${1:-.}"
}

alias aptinstall='sudo apt-get install -y'
alias aptupdate='sudo apt-get update'
alias aptupgrade='sudo apt-get upgrade -y'
alias upnup='sudo apt-get update; sudo apt-get dist-upgrade -y'
cleanup (){
	set -x
	echo "Cleaning up"
	sudo apt-get autoclean
	sudo apt-get clean
	sudo apt-get autoremove
	set +x
}

## a quick way to get out of current directory ##
alias ..="cd ../"
alias ...="cd ../../"
alias ....="cd ../../../"
alias .....="cd ../../../../"

# vim helpers
alias vi=vim
alias svi='sudo vi'
alias vis='vim "+set si"'
alias svir='sudo vim -R'
alias edit='vim'

# print free disk space
diskfree(){
    df -h | grep /dev/sda1 | awk '{print $5}'
}

###############################################################################
# Search and replace on a file regex.
###############################################################################
snr() {
    if [[ -n ${DRY_RUN+x} ]]; then  # Do a dry run
        find . -name "$1" -type f -exec sed -n "s/$2/$3/gp" {} \;
    else
        find . -name "$1" -type f -exec sed -i "s/$2/$3/g" {} \;
    fi
}

### End sys aliasing...for now
###############################################################################

###############################################################################
# Python
###############################################################################
# Expand Python file trees, w/o showing stupid .pyc files
alias pytree='tree -I *.pyc --prune .'
# Pip
alias pipu='pip2 install --user'
alias pip3u='pip3 install --user'
# Uninstall every Python package
alias pipclear='pip freeze | grep -v "^-e" | xargs pip uninstall -y'
# Delete all __pycache__/.pyc files
alias rmpyc="find . -name __pycache__ -type d -delete -o -name '*.pyc' -type f -delete"
# IPython, you so *handy*
alias ipy=ipython3

###############################################################################
# Go
###############################################################################

###############################################################################
# Run 'goimports' on all *.go files in directory.
###############################################################################
gimps(){
    find ! -readable -prune -name '*.go'  -exec goimports -w {} \;
}

###############################################################################
# Print the Go package for the cwd.
# Example: ~/go/src/github.com/jad-b/repo => github.com/jad-b/repo
###############################################################################
gopkg() {
	local cwd=$(pwd)
	if [[ $cwd == ~/go/src* ]]; then
		echo "${cwd#~/go/src/}"
	fi
}


# Git
###############################################################################
git-me() {
	git config user.email j.american.db@gmail.com
	git config user.name "Jeremy Dobbins-Bucklad"
	git config user.signingkey E180BC0A
}
alias ga='git add'
alias gai='git add --interactive'
alias gap='git add --patch'
alias gall='git add . --all'
alias gals="grep git ~/.bash_aliases"
alias gb='git branch'
alias gbv='git branch -vv'
alias gc='git checkout'
alias gcb='git checkout -t origin/master -b'
alias gcl='git clone'
alias gd='git diff'
alias gdc='git diff --cached'
alias gdcss='git diff --cached --shortstat'
alias gdss='git diff --shortstat'
alias gf='git fetch'
alias gfb='git filter-branch --tree-filter'
alias gl='git log'
alias gl1='git log --oneline'
alias gm='git commit -m'
alias gma='git commit -am'
alias gms='git commit -S -m'
alias gmt='git mergetool'
alias gra='git remote add'
alias grc='git rebase --continue'
alias gsk='git rebase --skip'
alias grr='git remote rm'
alias grv='git remote -v'
alias gs='git status'
alias pull='git pull'
alias push='git push'
###############################################################################
# Add filename to the git repo's exclude list
###############################################################################
gign() {
	echo "$1" >> "$(git rev-parse --show-toplevel)/.git/info/exclude"
}

# Removes old branches that have been merged into master
alias sweep="git branch --merged master | egrep -v '^\s+master$' | xargs -n 1 git branch -d"
# Upgrade every Git repo under a directory name using 'git-up'
gitemup() {
    printf "Updating git repos in %s..." "$1"
    for repo in $1/*/; do
        ( cd $repo && git up 2>/dev/null &) 1>/dev/null
    done
    wait
    echo "Done."
}
# Terraform
alias tf='terraform'

# Vagrant
alias vals='grep vagrant ~/.bash_aliases'
alias v='vagrant'
alias vb='vagrant box'
alias vbl='vagrant box list'
alias vdes='vagrant destroy -f'
alias vhalt='vagrant halt'
alias vup='vagrant up'
alias vpro='vagrant provision'
alias vre='vagrant reload'
alias vsh='vagrant ssh'
alias vgs='vagrant global-status'
alias vs='vagrant status'

# Make a base64 encoded secret
mksecret(){ echo "$1" | openssl dgst -binary -sha1 | openssl base64; }

# GPG
gpgctl() {
	case "$1" in
		decrypt|d)
			gpg --decrypt "$2"
			;;
		encrypt|e)
			local FILE="$2"
			local RECIPIENTS="-r $EMAIL"
			for name in "${@:3}"; do
				RECIPIENTS="$RECIPIENTS -r $name"
			done
			printf "Encrypting %s for recipients: %s\n" "$FILE" "${RECIPIENTS[@]}"
			gpg --encrypt --sign --armor "$RECIPIENTS" "$FILE"
			;;
		list|s)
			gpg --list-keys
			;;
		public|p)
			gpg --armor --export "$EMAIL"
			;;
		search|s) # Add someone's key
			gpg --keyserver pgp.mit.edu --search-keys "$2";
			;;
	esac
}



###############################################################################
# Common TLS operations
###############################################################################
tls() {
    local SSL_PRIVATE_KEY=privatekey.pem
    local SSL_CSR=csr.pem
    local SSL_CERT=server.crt
    case "$1" in
        view) # Display a cert, even in encoded .pem format.
            openssl x509 -in "$2" -text -noout
            ;;
		view-bundle) # Display a concatenated list of certs in a file
			openssl crl2pkcs7 -nocrl -certfile "$2" |\
			openssl pkcs7 -print_certs -text -noout
			;;
        server) # Open a TLS connection to a live server; $2 should be 'host:port'
            openssl s_client -connect "$2" -showcerts -servername "${2%:*}"
            ;;
		compare) # Check a public cert and private key for compatibility
			openssl x509 -noout -modulus -in "$2" | openssl md5;\
			openssl rsa -noout -modulus -in "$3" | openssl md5
			# Pipe through 'uniq' for a quick view of any differences
			;;
        key) # Generate a TLS key
            KEY=${2:-$SSL_PRIVATE_KEY};
            STRENGTH=${3:-2048};
            openssl genrsa "$STRENGTH" > "$KEY"
            ;;
        csr) # Generate a Certificate Signing Request
            KEY=${2:-$SSL_PRIVATE_KEY}
            CSR=${3:-$SSL_CSR}
            openssl req -new -key "$KEY" -out "$CSR"
            ;;
        cert) # Generate a self-signed TLS certificate
            KEY=${2:-$SSL_PRIVATE_KEY}
            CSR=${3:-$SSL_CSR}
            CERT=${4:-$SSL_CERT}
            openssl x509 -req -days 365 -signkey "$KEY" -in "$CSR" -out "$CERT"
            ;;
    esac
}

# Automatically add completion for all aliases to commands having completion functions
function alias_completion {
    local namespace="alias_completion"

    # parse function based completion definitions, where capture group 2 => function and 3 => trigger
    local compl_regex='complete( +[^ ]+)* -F ([^ ]+) ("[^"]+"|[^ ]+)'
    # parse alias definitions, where capture group 1 => trigger, 2 => command, 3 => command arguments
    local alias_regex="alias ([^=]+)='(\"[^\"]+\"|[^ ]+)(( +[^ ]+)*)'"

    # create array of function completion triggers, keeping multi-word triggers together
    eval "local completions=($(complete -p | sed -Ene "/$compl_regex/s//'\3'/p"))"
    (( ${#completions[@]} == 0 )) && return 0

    # create temporary file for wrapper functions and completions
    rm -f "/tmp/${namespace}-*.tmp" # preliminary cleanup
    local tmp_file; tmp_file="$(mktemp "/tmp/${namespace}-${RANDOM}XXX.tmp")" || return 1

    local completion_loader; completion_loader="$(complete -p -D 2>/dev/null | sed -Ene 's/.* -F ([^ ]*).*/\1/p')"

    # read in "<alias> '<aliased command>' '<command args>'" lines from defined aliases
    local line; while read line; do
        eval "local alias_tokens; alias_tokens=($line)" 2>/dev/null || continue # some alias arg patterns cause an eval parse error
        local alias_name="${alias_tokens[0]}" alias_cmd="${alias_tokens[1]}" alias_args="${alias_tokens[2]# }"

        # skip aliases to pipes, boolean control structures and other command lists
        # (leveraging that eval errs out if $alias_args contains unquoted shell metacharacters)
        eval "local alias_arg_words; alias_arg_words=($alias_args)" 2>/dev/null || continue
        # avoid expanding wildcards
        read -a alias_arg_words <<< "$alias_args"

        # skip alias if there is no completion function triggered by the aliased command
        if [[ ! " ${completions[*]} " =~ " $alias_cmd " ]]; then
            if [[ -n "$completion_loader" ]]; then
                # force loading of completions for the aliased command
                eval "$completion_loader $alias_cmd"
                # 124 means completion loader was successful
                [[ $? -eq 124 ]] || continue
                completions+=($alias_cmd)
            else
                continue
            fi
        fi
        local new_completion="$(complete -p "$alias_cmd")"

        # create a wrapper inserting the alias arguments if any
        if [[ -n $alias_args ]]; then
            local compl_func="${new_completion/#* -F /}"; compl_func="${compl_func%% *}"
            # avoid recursive call loops by ignoring our own functions
            if [[ "${compl_func#_$namespace::}" == $compl_func ]]; then
                local compl_wrapper="_${namespace}::${alias_name}"
                    echo "function $compl_wrapper {
                        (( COMP_CWORD += ${#alias_arg_words[@]} ))
                        COMP_WORDS=($alias_cmd $alias_args \${COMP_WORDS[@]:1})
                        (( COMP_POINT -= \${#COMP_LINE} ))
                        COMP_LINE=\${COMP_LINE/$alias_name/$alias_cmd $alias_args}
                        (( COMP_POINT += \${#COMP_LINE} ))
                        $compl_func
                    }" >> "$tmp_file"
                    new_completion="${new_completion/ -F $compl_func / -F $compl_wrapper }"
            fi
        fi

        # replace completion trigger by alias
        new_completion="${new_completion% *} $alias_name"
        echo "$new_completion" >> "$tmp_file"
    done < <(alias -p | sed -Ene "s/$alias_regex/\1 '\2' '\3'/p")
    source "$tmp_file" && rm -f "$tmp_file"
}; alias_completion
