#!/usr/bin/env sh
set -o errexit

# Exclude SC1090 - to avoid warnings about assumed files present that shellcheck can't read
# Exclude SC1091 - to avoid warnings about assumed files present that shellche,ck can't read
# Exclude SC1012 - for \r being used in sed command, the suggested behavior is incorrect for the use-case.
shellcheck --shell=bash --exclude=SC1090,SC1091,SC1012 personal-env*

exit 0