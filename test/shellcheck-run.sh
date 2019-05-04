#!/usr/bin/env sh
set -o errexit

# Exclude SC1090 - To avoid warnings about assumed files present that shellcheck can't read
# Exclude SC1091 - To avoid warnings about assumed files present that shellcheck can't read
shellcheck --shell=bash --exclude=SC1090,SC1091 personal-env*

exit 0