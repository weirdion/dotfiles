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
