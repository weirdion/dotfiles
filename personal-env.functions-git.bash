#!/usr/bin/env bash

source "$(dirname "${BASH_SOURCE[0]}")/personal-env.functions-helpers.bash"

function __parse_git_branch() {
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# stashes the uncommited code, pulls from origin then unstashes
# Warning if there are conflicts it will not show in interactive UI
function branchUpdate() {
	stashRunUnstash() {
		unCommittedChanges="Changes not staged for commit:"

		if git status | grep "$unCommittedChanges" ; then
			__printInYellow "\nSaving changes to stash\n" && \
			git stash save && \
			__printInYellow "\nPulling from tracking repo..\n" && \
			$1 && \
			__printInYellow "\nUnstashing changes from stash\n" && \
			git stash pop
		else
			__printInGreen "\nNo local changes found.." && \
			__printInGreen "\nPulling from tracking repo..\n" && \
			$1
		fi
	}
	stashRunUnstash "git pull --rebase"
}

function gitDiffWithBranch() {
	currentBranch=$(git for-each-ref --format='%(upstream:short)' "$(git symbolic-ref -q HEAD)")
	git diff HEAD "${1:-$currentBranch}"
}

function logDiffBetweenBranches() {
	echo "Showing $1..$2"
	git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset  %s %Cgreen(%cr)%Creset' --abbrev-commit --date=relative "$1".."$2"
	echo
	echo "Showing $2..$1"
	git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset  %s %Cgreen(%cr)%Creset' --abbrev-commit --date=relative "$2".."$1"
}
