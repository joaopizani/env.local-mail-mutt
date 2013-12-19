#!/usr/bin/env bash

echo "Installing prerequisite packages"
sudo apt-get install $(cat ubuntu-packages-needed)

cat <(crontab -l) <(cron-jobs) | crontab -

./install-basic.sh
