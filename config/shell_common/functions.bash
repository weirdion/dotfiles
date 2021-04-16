#!/usr/bin/env bash

COLOR_RED='\033[0;31m'
COLOR_GREEN='\033[0;32m'
COLOR_YELLOW='\033[1;33m'
COLOR_LBLUE='\033[1;34m'
COLOR_WHITE='\033[0;37m'
COLOR_NONE='\033[0m'

function __printInColor() {
	echo -e "$2$1${COLOR_NONE}"
}

function __printInRed() {
	__printInColor "$1" "$COLOR_RED"
}

function __printInGreen() {
	__printInColor "$1" "$COLOR_GREEN"
}

function __printInYellow() {
	__printInColor "$1" "$COLOR_YELLOW"
}

function __printInBlue() {
	__printInColor "$1" "$COLOR_LBLUE"
}

function __printInWhite() {
	__printInColor "$1" "$COLOR_WHITE"
}

function __checkIfRoot() {
	if [ "$(id -u)" -ne 0 ]
	then
	  __printInRed "\nERROR: You must run this command with sudo.";
	  exit 1;
	fi
}

function __checkIfNotRoot() {
	if [ "$(id -u)" -eq 0 ]
	then
	  __printInRed "\nERROR: You must NOT use this command as sudo.";
	  exit 1;
	fi
}

function pidinfo() {
  if [ "$#" -eq 1 ]; then
    ps -p "$1" -o pid,user,comm,cmd
  else
    __printInRed "Unable to execute the command."
    __printInWhite "Usage: pidname PID"
  fi
}

function pullSSLCert() {
	if [ "$#" -eq 1 ]
	then
		openssl s_client -showcerts -connect "${1}":443 < /dev/null 2> /dev/null | openssl x509 -noout -text
	else
		__printInRed "Unable to execute the command."
		__printInWhite "Usage: pullSSLCert webaddress"	
	fi
}

function getCertKeyPemFromPfx() {
	if [ "$#" -eq 1 ]
	then
		openssl pkcs12 -in "$1.pfx" -out "$1-cert.pem" -clcerts -nokeys
    	openssl pkcs12 -in "$1.pfx" -out "$1-key.pem" -nocerts -nodes
	else
		__printInRed "Unable to execute the command."
		__printInWhite "Usage: getCertKeyPemFromPfx name_of_the_pfx"
	fi
}

function sshfs-mount() {
	if [ "$#" -ge 2 ]; then
		sshfs -o uid="$(id -u "$LOGNAME")" -o gid="$(id -u "$LOGNAME")" -o reconnect -o  ServerAliveInterval=15 "$1" "$2"
	else
		__printInRed "Unable to execute the command."
		__printInWhite "Usage sshfs-mount [sshfs options] source destination"
	fi
}

function sshfs-umount() {
	if [ "$#" -eq 1 ]; then
		fusermount3 -u "$1"
	else
		__printInRed "Unable to execute the command."
		__printInWhite "Usage sshfs-umount [fusermount options] destination"
	fi
}

function sync-folder-local2remote() {
	if [[ "$#" -eq 2 ]]; then
		rsync --progress -vr --ignore-existing "$1" "$2$1"
	else
		__printInRed "Unable to execute the command."
		__printInWhite "Usage sync-folder-local2remote local-folder remote:path"
		__printInWhite "Example: \`sync-folder-local2remote folder1 dummyremote:/home/user/\` will sync local folder1 with dummyremote:/home/user/folder1"
	fi
}
