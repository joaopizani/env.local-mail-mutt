#!/usr/bin/env bash

DIR="$(cd -P "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")" )" && pwd)"


ln -f -s -n "${DIR}/offlineimap/offlineimap.rc"  "${HOME}/.offlineimaprc"
ln -f -s -n "${DIR}/offlineimap/offlineimap.py"  "${HOME}/.offlineimap.py"
touch "${DIR}/mutt/oi.boxes"

