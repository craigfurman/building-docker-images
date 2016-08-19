#!/usr/bin/env bash
set -eu
set -o pipefail

(
cd $(dirname $0)
docker build -t craigfurman/ubuntu-with-ssh-server .
)
