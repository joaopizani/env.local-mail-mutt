#!/usr/bin/env bash

DIR="$(cd -P "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")" )" && pwd)"

git clone git://gist.github.com/6572826.git "${DIR}/pydelatt"
chmod +x "${DIR}/pydelatt/pydelatt.py"

ln -s -f -n "${DIR}/pydelatt/pydelatt.py"     "${HOME}/bin/pydelatt.py"
ln -s -f -n "${DIR}/delatt-maildir"           "${HOME}/bin/delatt-maildir"
ln -s -f -n "${DIR}/archive-comm"             "${HOME}/bin/archive-comm"

