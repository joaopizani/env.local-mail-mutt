#!/usr/bin/env bash

REL_SRC=${BASH_SOURCE[0]}
CANONICAL_SRC=$(readlink -f "$REL_SRC")
DIR="$(cd -P "$(dirname $CANONICAL_SRC)" && pwd)"

EMAIL_ADDRESS_FILE_LINK="${HOME}/.localmail-custom/username-gmail"
EMAIL_ADDRESS=$(cat "${EMAIL_ADDRESS_FILE_LINK}")

cat <<EOF > "${DIR}/msmtp.rc"
account gmail
host smtp.gmail.com
port 587
protocol smtp
auth on
from ${EMAIL_ADDRESS}
user ${EMAIL_ADDRESS}
tls on
tls_starttls on
tls_trust_file /etc/ssl/certs/ca-certificates.crt

account default : gmail
logfile ~/.msmtp.log
EOF

