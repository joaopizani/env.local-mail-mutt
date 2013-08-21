#!/usr/bin/env bash

REL_SRC=${BASH_SOURCE[0]}
CANONICAL_SRC=$(readlink -f $REL_SRC)
DIR="$(cd -P "$(dirname $CANONICAL_SRC)" && pwd)"


mkdir -p ${HOME}/mail/{mail,mu}
ln -f -s ${HOME}/mail/mail                    ${HOME}/.mail
ln -f -s ${HOME}/mail/mu                      ${HOME}/.mu

ln -f -s ${DIR}/mutt                          ${HOME}/.mutt

ln -f -s ${DIR}/misc-tools/mutt-open          ${HOME}/bin/mutt-open
ln -f -s ${DIR}/misc-tools/urlview            ${HOME}/.urlview

ln -f -s ${DIR}/msmtp.rc                      ${HOME}/.msmtprc

ln -f -s ${DIR}/offlineimap/offlineimap.rc    ${HOME}/.offlineimaprc
ln -f -s ${DIR}/offlineimap/offlineimap.py    ${HOME}/.offlineimap.py

ln -f -s ${DIR}/goobook/goobook.rc            ${HOME}/.goobookrc
chmod +x ${DIR}/goobook/goobook_getpass.sh
ln -f -s ${DIR}/goobook/goobook_getpass.sh    ${HOME}/.goobook_getpass.sh


read -r -d '' PYCMD <<'EOF'
import keyring
pw = raw_input("gmail-password-onetime> ")
keyring.set_password("localmail-gmail", "joaopizani@gmail.com", pw)
EOF

python -c "$PYCMD"

