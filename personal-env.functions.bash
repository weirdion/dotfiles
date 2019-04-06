#!/usr/bin/env bash

COLOR_RED='\033[0;31m'
COLOR_GREEN='\033[0;32m'
COLOR_YELLOW='\033[1;33m'
COLOR_LBLUE='\033[1;34m'
COLOR_NONE='\033[0m'

function __checkIfRoot() {
	if [ $? -ne 0 ]
	then
	  echo -e "\nERROR: You must run this command with sudo.";
	  exit 1;
	fi
}

function __checkIfNotRoot() {
	if [ $? -eq 0 ]
	then
	  echo -e "\nERROR: You must NOT use this command as sudo.";
	  exit 1;
	fi
}

function __printInColor() {
	echo -e "$2$1${COLOR_NONE}"
}

function __printInRed() {
	__printInColor "$1" $COLOR_RED
}

function __printInGreen() {
	__printInColor "$1" $COLOR_GREEN
}

function __printInYellow() {
	__printInColor "$1" $COLOR_YELLOW
}

function __printInBlue() {
	__printInColor "$1" $COLOR_LBLUE
}

# stashes the uncommited code, pulls from origin then unstashes
# Warning if there are conflicts it will not show in interactive UI
function branchUpdate() {
	stashRunUnstash() {
		unCommittedChanges="Changes not staged for commit:"

		if git status | grep "$unCommittedChanges" ; then
			echo -e "\nSaving changes to stash\n" && \
			git stash save && \
			echo -e "\nPulling from tracking repo..\n" && \
			$1 && \
			echo -e "\nUnstashing changes from stash\n" && \
			git stash pop
		else
			echo -e "\nNo local changes found.." && \
			echo -e "\nPulling from tracking repo..\n" && \
			$1
		fi
	}
	stashRunUnstash "git pull --rebase"
}

# TODO: This should be moved to git aliases script
function gitDiffWithBranch() {
	currentBranch=$(git for-each-ref --format='%(upstream:short)' $(git symbolic-ref -q HEAD))
	git diff HEAD "${1:-$currentBranch}"
}

# TODO: This should be moved to git aliases script
function logDiffBetweenBranches() {
	echo "Showing $1..$2"
	git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset  %s %Cgreen(%cr)%Creset' --abbrev-commit --date=relative $1..$2
	echo
	echo "Showing $2..$1"
	git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset  %s %Cgreen(%cr)%Creset' --abbrev-commit --date=relative $2..$1
}

function handBrakeConvert() {
	HandBrakeCLI -i "$1" -o "${2:-$(echo "$1" | sed -e 's/\(^.*[sS][0-9][0-9][eE][0-9][0-9]\)\(.*\)/\1/').mp4}" -e x264 -q 21 -B 160 && \
	rm "$1"
}

function convertAndRmAllInFolder() {
	for file in $(find "${2:-./}" -type f -name "*.${1:-mkv}"); do
		handBrakeConvert "$file"
	done
}

function pullSSLCert() {
	openssl s_client -showcerts -connect "${1}":443 < /dev/null 2> /dev/null | openssl x509 -noout -text
}

# Get keys from mit liscence keys
function getGPGKey() {
	gpg --recv-keys --keyserver hkp://pgp.mit.edu $1
}

function getCertKeyPemFromPfx() {
	openssl pkcs12 -in "$1.pfx" -out "$1-cert.pem" -clcerts -nokeys
    openssl pkcs12 -in "$1.pfx" -out "$1-key.pem" -nocerts -nodes
}
