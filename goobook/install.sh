#!/usr/bin/env bash

REL_SRC=${BASH_SOURCE[0]}
CANONICAL_SRC=$(readlink -f $REL_SRC)
DIR="$(cd -P "$(dirname $CANONICAL_SRC)" && pwd)"

"${DIR}/goobookrc-generate.sh"
ln -f -s -n "${DIR}/goobook.rc"             "${HOME}/.goobookrc"

chmod +x "${DIR}/goobook_getpass.sh"
ln -f -s -n "${DIR}/goobook_getpass.sh"     "${HOME}/.goobook_getpass.sh"

touch "${DIR}/goobook_cache"
ln -f -s -n "${DIR}/goobook_cache"          "${HOME}/.goobook_cache"

