#!/usr/bin/env bash

DIR="$(cd -P "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")" )" && pwd)"

W3MDIR="${HOME}/.w3m"
mkdir -p "${W3MDIR}"

ln -f -s -n "${DIR}/config"  "${W3MDIR}/config"
ln -f -s -n "${DIR}/keymap"  "${W3MDIR}/keymap"

