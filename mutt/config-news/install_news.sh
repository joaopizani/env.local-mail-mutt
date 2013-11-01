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
ln -f -s -T ${NDIR_TRUE} ${NDIR_GLOBAL}

maildir-feed ${NDIR_GLOBAL}

CNT=0  # numbered links only work now from 0 until 9, TODO two-digit numbers
for n in $(ls -A1 ${NDIR_TRUE}); do
    ln -f -s "${NDIR_TRUE}/${n}" "${NDIR_LINKS}/${CNT}_$(echo ${n} | sed 's/^.//')"
    (( CNT++ ))
done


# Now, create the news-mailboxes file and mutt-news.rc
NEWSBOXES_FILE="${DIR}/mailboxes-news"
echo $(ls -A1 ${NDIR_LINKS}) > "${NEWSBOXES_FILE}-dirs"
cp "${NEWSBOXES_FILE}-dirs" ${NEWSBOXES_FILE}

# mailboxes-news
sed -i "s/ \(.\)/ +${NDIR_NAME}\/\1/g"  ${NEWSBOXES_FILE}  # cheesy whitespace handling
sed -i "s/\(.\)/ +${NDIR_NAME}\/\1/"    ${NEWSBOXES_FILE}

# mutt-news.rc
RCPREFIX="macro index,pager gw"
RCSUFFIX="<enter>\" \"go news\""
NEWSRC="${DIR}/mutt-news.rc"
SYNCLINE="macro index O \"<shell-escape>maildir-feed ${NDIR_GLOBAL}<enter>\" \"synchronize news\""

tr " " "\n" < "${NEWSBOXES_FILE}-dirs" > ${NEWSRC}  # cheesy whitespace handling
sed -i "s/\(^[0-9]\+\)\(.*\)/${RCPREFIX}\1 \"<change-folder>+${NDIR_NAME}\/\1\2${RCSUFFIX}/g" ${NEWSRC}
echo ${SYNCLINE} >> ${NEWSRC}

rm "${NEWSBOXES_FILE}-dirs"

