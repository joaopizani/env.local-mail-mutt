#!/usr/bin/env bash

DIR="$(cd -P "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")" )" && pwd)"


"${DIR}/install-basic.sh"

cat <(crontab -l) "${DIR}/cron-jobs" | crontab -

"${DIR}/news/install_maildir-feed.sh"
"${DIR}/news/install_news.sh"

