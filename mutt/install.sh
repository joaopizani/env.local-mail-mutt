#!/usr/bin/env bash

DIR="$(cd -P "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")" )" && pwd)"


mkdir -p "${HOME}/comm/mutt"
mkdir -p "${DIR}/mutt/temp" "${DIR}/mutt/cache/"{headers,bodies}
mkdir -p "${HOME}/Downloads/mutt-attachments"

ln -f -s -n "${HOME}/comm/mutt"  "${HOME}/.mail"
ln -f -s -n "${DIR}/mutt"        "${HOME}/.mutt"

ln -f -s -n "${DIR}/mutt/themes/inkpot-256.theme"  "${DIR}/mutt/themes/current-theme.rc"

ln -f -s -n "${DIR}/archival/mutt-open"  "${HOME}/bin/mutt-open"

