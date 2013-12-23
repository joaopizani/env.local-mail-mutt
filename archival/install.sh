#!/usr/bin/env bash

REL_SRC=${BASH_SOURCE[0]}
CANONICAL_SRC=$(readlink -f $REL_SRC)
DIR="$(cd -P "$(dirname $CANONICAL_SRC)" && pwd)"

git clone git://gist.github.com/6572826.git      ${DIR}/pydelatt
chmod +x ${DIR}/pydelatt/pydelatt.py

ln -s -f "${DIR}/pydelatt/pydelatt.py"     "${HOME}/bin/pydelatt.py"
ln -s -f "${DIR}/delatt-maildir"           "${HOME}/bin/delatt-maildir"
ln -s -f "${DIR}/archive-comm"             "${HOME}/bin/archive-comm"

