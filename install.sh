#!/usr/bin/env bash

REL_SRC=${BASH_SOURCE[0]}
CANONICAL_SRC=$(readlink -f $REL_SRC)
DIR="$(cd -P "$(dirname $CANONICAL_SRC)" && pwd)"

mkdir -p ${HOME}/bin

# mail directories, mutt directories and mu directories
mkdir -p ${HOME}/comm/mutt
ln -f -s ${HOME}/comm/mutt                       ${HOME}/.mail
mkdir -p ${DIR}/mu/{cache,xapian,results,log}
ln -f -s ${DIR}/mu                               ${HOME}/.mu

ln -f -s ${DIR}/mutt                             ${HOME}/.mutt
mkdir -p ${HOME}/Downloads/mutt-attachments

# mutt-open and urlview
ln -f -s ${DIR}/misc-tools/mutt-open             ${HOME}/bin/mutt-open
ln -f -s ${DIR}/misc-tools/urlview               ${HOME}/.urlview

# msmtp
./msmtp/install.sh

# offlineimap
ln -f -s ${DIR}/offlineimap/offlineimap.rc       ${HOME}/.offlineimaprc
ln -f -s ${DIR}/offlineimap/offlineimap.py       ${HOME}/.offlineimap.py

# pydelatt, archival, etc.
git clone git://gist.github.com/6572826.git      ${DIR}/misc-tools/pydelatt
chmod +x ${DIR}/misc-tools/pydelatt/pydelatt.py
ln -s ${DIR}/misc-tools/pydelatt/pydelatt.py     ${HOME}/bin/pydelatt.py
ln -s ${DIR}/misc-tools/delatt-maildir.sh        ${HOME}/bin/delatt-maildir.sh
ln -s ${DIR}/misc-tools/archive-maildirs.sh      ${HOME}/bin/archive-maildirs.sh

# goobook
./goobook/install.sh


# Setting username and password in the system keyring

EMAIL_ADDRESS_FILE="${DIR}/username-gmail"
EMAIL_ADDRESS_FILE_LINK="${HOME}/.localmail-username-gmail"
ln -s -f ${EMAIL_ADDRESS_FILE} ${EMAIL_ADDRESS_FILE_LINK}

EMAIL_ADDRESS=$(cat ${EMAIL_ADDRESS_FILE_LINK})

read -r -d '' PYCMD <<EOF
import keyring
keyring.set_password("localmail-gmail", ${EMAIL_ADDRESS}, raw_input("gmail-password > "))
EOF

python -c "$PYCMD"

