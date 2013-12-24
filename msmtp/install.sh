#!/usr/bin/env bash

REL_SRC=${BASH_SOURCE[0]}
CANONICAL_SRC=$(readlink -f $REL_SRC)
DIR="$(cd -P "$(dirname $CANONICAL_SRC)" && pwd)"


"${DIR}/msmtprc-generate.sh"
ln -f -s -n "${DIR}/msmtp.rc"     "${HOME}/.msmtprc"

ln -f -s -n "${DIR}/msmtp.log"    "${HOME}/.msmtp.log"

