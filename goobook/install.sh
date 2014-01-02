#!/usr/bin/env bash

DIR="$(cd -P "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")" )" && pwd)"

"${DIR}/goobookrc-generate.sh"
ln -f -s -n "${DIR}/goobook.rc"             "${HOME}/.goobookrc"

chmod +x "${DIR}/goobook_getpass.sh"
ln -f -s -n "${DIR}/goobook_getpass.sh"     "${HOME}/.goobook_getpass.sh"

touch "${DIR}/goobook_cache"
ln -f -s -n "${DIR}/goobook_cache"          "${HOME}/.goobook_cache"

