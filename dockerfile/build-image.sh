#!/usr/bin/env bash
set -eu
set -o pipefail

dockerfile=$(cd $(dirname $0) && pwd)/Dockerfile

(
cd $(dirname $0)/..
docker build -t craigfurman/app-built-with-dockerfile -f $dockerfile .
)
