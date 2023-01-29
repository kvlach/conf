#!/bin/bash

alias l='ls -la'

c() {
	cd "$@" && clear && l
}

alias c.='c ..'

e() {
	kak "$@" || nvim "$@" || vim "$@" || nano "$@" || vi "$@"
}

alias df='df -h'

alias ga='git add'
alias gd='git diff'
alias gs='git status'

alias ta='tmux attach'
alias tl='tmux list-sessions'

conf() {
	# git init --bare ~/.cache/config-work.git/
	# conf config --local status.showUntrackedFiles no
	# conf config user.email 'kon@vlach.gr'
	# conf config user.name 'Konstantinos Vlachopoulos'
	# conf config core.sshCommand 'ssh -i ~/.ssh/kvlach'

	git \
		--git-dir="${XDG_CACHE_HOME:-$HOME/.cache}/config-work.git" \
		--work-tree="$HOME" \
		"$@"
}
