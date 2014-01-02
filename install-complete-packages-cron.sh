#!/usr/bin/env bash

DIR="$(cd -P "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")" )" && pwd)"

echo "Installing prerequisite packages"
sudo apt-get install $(cat ubuntu-packages-needed)

cat <(crontab -l) <(cron-jobs) | crontab -

"${DIR}/install-basic.sh"

