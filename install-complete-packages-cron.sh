#!/usr/bin/env bash

REL_SRC=${BASH_SOURCE[0]}
CANONICAL_SRC=$(readlink -f $REL_SRC)
DIR="$(cd -P "$(dirname $CANONICAL_SRC)" && pwd)"

echo "Installing prerequisite packages"
sudo apt-get install $(cat ubuntu-packages-needed)

cat <(crontab -l) <(cron-jobs) | crontab -

"${DIR}/install-basic.sh"

