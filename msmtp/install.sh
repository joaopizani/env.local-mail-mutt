#!/usr/bin/env bash

REL_SRC=${BASH_SOURCE[0]}
CANONICAL_SRC=$(readlink -f $REL_SRC)
DIR="$(cd -P "$(dirname $CANONICAL_SRC)" && pwd)"


./msmtprc-generate.sh
ln -f -s ${DIR}/msmtp.rc     ${HOME}/.msmtprc

ln -f -s ${DIR}/msmtp.log    ${HOME}/.msmtp.log

