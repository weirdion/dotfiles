#!/usr/bin/env bash

# shellcheck disable=SC2044
for i in $(find "$(dirname "${BASH_SOURCE[0]}")" -maxdepth 1 -iname "personal-env.functions-*.bash"); do
	source "$i"
done

function pidinfo() {
  if [ "$#" -eq 1 ]; then
    ps -p "$1" -o pid,user,comm,cmd
  else
    __printInRed "Unable to execute the command."
    __printInWhite "Usage: pidname PID"
  fi
}
