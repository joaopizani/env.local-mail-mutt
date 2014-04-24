#!/usr/bin/env bash

DIR="$(cd -P "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")" )" && pwd)"

mkdir -p "${GOPATH}"
go get github.com/sloonz/maildir-feed/maildir-feed
go get github.com/sloonz/maildir-feed/maildir-feed-rss

