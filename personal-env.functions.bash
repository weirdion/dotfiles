#!/usr/bin/env bash

source "$(dirname "${BASH_SOURCE[0]}")/personal-env.functions-helpers.bash"
source "$(dirname "${BASH_SOURCE[0]}")/personal-env.functions-git.bash"
source "$(dirname "${BASH_SOURCE[0]}")/personal-env.functions-media.bash"
source "$(dirname "${BASH_SOURCE[0]}")/personal-env.functions-scan.bash"

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

# Get keys from mit liscence keys
function getGPGKey() {
	if [ "$#" -eq 1 ]
	then
		gpg --recv-keys --keyserver hkp://pgp.mit.edu "$1"
	else
		__printInRed "Unable to execute the command."
		__printInWhite "Usage: getGPGKey keyID"
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
