#!/usr/bin/env bash

DIR="$(cd -P "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")" )" && pwd)"

EMAIL_ADDRESS_FILE_LINK="${HOME}/.localmail-custom/username-gmail"
EMAIL_ADDRESS="$(cat "${EMAIL_ADDRESS_FILE_LINK}")"

cat <<EOF > "${DIR}/goobook.rc"
[DEFAULT]
email: ${EMAIL_ADDRESS}
passwordeval: ~/.goobook_getpass.sh

cache_filename: ~/.goobook_cache
cache_expiry_hours: 2
filter_groupless_contacts: no
EOF

