#!/usr/bin/env sh
set -o errexit

echo "Running check on bash scripts"
# SC2148: bashrc doesn't need shebang
# SC1090: ignore non-constant source, whole point of this is to be adaptable.
shellcheck --shell=bash -x --exclude=SC2148,SC1090 config/bash/.bashrc

echo
echo "Running check on bin dir"
# SC1071: Ignore zsh script
shellcheck --shell=bash --exclude=SC1071 bin/*

exit 0