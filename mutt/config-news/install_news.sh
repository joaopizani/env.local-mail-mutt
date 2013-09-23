#!/usr/bin/env bash

REL_SRC=${BASH_SOURCE[0]}
CANONICAL_SRC=$(readlink -f $REL_SRC)
DIR="$(cd -P "$(dirname $CANONICAL_SRC)" && pwd)"

mkdir -p "${HOME}/.cache/rss2maildir" "${HOME}/.config/rss2maildir"
ln -f -s "${DIR}/feeds.json" "${HOME}/.config/rss2maildir/feeds.json"

NDIR_NAME="news"
MUTTROOT="${HOME}/comm/mutt"
NDIR_TRUE="${HOME}/comm/.news"
NDIR_LINKS="${MUTTROOT}/${NDIR_NAME}"
NDIR_GLOBAL="${HOME}/.news"

mkdir -p ${NDIR_TRUE} ${NDIR_LINKS}
ln -f -s ${NDIR_TRUE} ${NDIR_GLOBAL}

maildir-feed ${NDIR_GLOBAL}

CNT=0
for n in $(ls -A1 ${NDIR_TRUE}); do
    ln -f -s "${NDIR_TRUE}/${n}" "${NDIR_LINKS}/${CNT}_$(echo ${n} | sed 's/^.//')"
    (( CNT++ ))
done

# Now, create the news-mailboxes file
NEWSBOXES_FILE="${DIR}/mailboxes-news"
echo $(ls -A1 ${NDIR_LINKS}) >          ${NEWSBOXES_FILE}
sed -i "s/ \(.\)/ +${NDIR_NAME}\/\1/g"  ${NEWSBOXES_FILE}
sed -i "s/\(.\)/ +${NDIR_NAME}\/\1/"    ${NEWSBOXES_FILE}

