#!/usr/bin/env bash

REL_SRC=${BASH_SOURCE[0]}
CANONICAL_SRC=$(readlink -f $REL_SRC)
DIR="$(cd -P "$(dirname $CANONICAL_SRC)" && pwd)"

EMAIL_ADDRESS_FILE_LINK="${HOME}/.localmail-username-gmail"
EMAIL_ADDRESS=$(cat ${EMAIL_ADDRESS_FILE_LINK})

cat <<EOF > "${DIR}/goobook.rc"
[DEFAULT]
email: ${EMAIL_ADDRESS}
passwordeval: ~/.goobook_getpass.sh

# The following are optional, defaults are shown
cache_filename: ~/.goobook_cache
cache_expiry_hours: 2
filter_groupless_contacts: no
EOF

ln -f -s ${DIR}/goobook.rc               ${HOME}/.goobookrc

chmod +x ${DIR}/goobook_getpass.sh
ln -f -s ${DIR}/goobook_getpass.sh       ${HOME}/.goobook_getpass.sh

touch ${DIR}/goobook_cache
ln -f -s ${DIR}/goobook_cache            ${HOME}/.goobook_cache

