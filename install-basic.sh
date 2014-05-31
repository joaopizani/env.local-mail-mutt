#!/usr/bin/env bash

DIR="$(cd -P "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")" )" && pwd)"

"${DIR}/install-dependencies.sh"


# Setting username and password in the system keyring
EMAIL_ADDRESS_FILE_LINK="${HOME}/.localmail-custom/username-gmail"
EMAIL_ADDRESS=$(cat "${EMAIL_ADDRESS_FILE_LINK}")

read -r -d '' PYCMD <<EOF
import keyring
keyring.set_password("localmail-gmail", "${EMAIL_ADDRESS}", raw_input("gmail-password > "))
EOF

python -c "$PYCMD"


mkdir -p "${DIR}/mu"/{cache,xapian,results,log}  &&  ln -f -s -n "${DIR}/mu" "${HOME}/.mu"

"${DIR}/mutt/install.sh"
"${DIR}/offlineimap/install.sh"
"${DIR}/w3m/install.sh"
"${DIR}/msmtp/install.sh"
"${DIR}/archival/install.sh"
"${DIR}/goobook/install.sh"
"${DIR}/news/install_maildir-feed.sh"
"${DIR}/news/install_news.sh"

