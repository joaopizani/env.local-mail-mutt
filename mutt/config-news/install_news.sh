#!/usr/bin/env bash

REL_SRC=${BASH_SOURCE[0]}
CANONICAL_SRC=$(readlink -f $REL_SRC)
DIR="$(cd -P "$(dirname $CANONICAL_SRC)" && pwd)"

mkdir -p "${HOME}/.cache/rss2maildir" "${HOME}/.config/rss2maildir"
ln -f -s "${DIR}/feeds.json" "${HOME}/.config/rss2maildir/feeds.json"

NEWSDIR_TRUE="${HOME}/comm/.news"
NEWSDIR_LINKS="${HOME}/comm/mutt/news"
NEWSDIR_GLOBAL="${HOME}/.news"

mkdir -p ${NEWSDIR_TRUE} ${NEWSDIR_LINKS}
ln -f -s ${NEWSDIR_TRUE} ${NEWSDIR_GLOBAL}

maildir-feed
for n in $(ls -A1 ${NEWSDIR_TRUE}); do
    ln -f -s "${NEWSDIR_TRUE}/${n}" "${NEWSDIR_LINKS}/$(echo ${n} | sed 's/^.//')"
done

# Now, create the news-mailboxes file...
