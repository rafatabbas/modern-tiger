#!/usr/bin/env bash

set -e
set -o pipefail
set -v

curl -s -X POST https://api.stackbit.com/project/5e577fc0da4d8b00194d1eec/webhook/build/pull > /dev/null
if [[ -z "${STACKBIT_API_KEY}" ]]; then
    echo "WARNING: No STACKBIT_API_KEY environment variable set, skipping stackbit-pull"
else
    npx @stackbit/stackbit-pull --stackbit-pull-api-url=https://api.stackbit.com/pull/5e577fc0da4d8b00194d1eec 
fi
curl -s -X POST https://api.stackbit.com/project/5e577fc0da4d8b00194d1eec/webhook/build/ssgbuild > /dev/null
jekyll build

curl -s -X POST https://api.stackbit.com/project/5e577fc0da4d8b00194d1eec/webhook/build/publish > /dev/null
