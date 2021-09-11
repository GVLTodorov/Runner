#!/bin/bash

if [ -z ${TOKEN+x} ]; then
  echo "TOKEN environment variable is not set"
  exit 1
fi

if [ -z ${REPOSITORY+x} ]; then
  echo "REPOSITORY environment variable is not set."
  exit 1
fi

AUTH_HEADER="Authorization: token ${TOKEN}"
URL=$REPOSITORY/actions/runners/registration-token

RTOKEN="$(curl -XPOST -fsSL \
  -H "${AUTH_HEADER}" \
  "${URL}" \
| jq -r '.token')"

cd /home/docker/actions-runner

./config.sh --url $REPOSITORY --token $RTOKEN --name $NAME --labels $LABEL --work ${DIR}

cleanup() {
    echo "Removing runner..."
    ./config.sh remove --unattended --token $RTOKEN
}

trap 'cleanup; exit 130' INT
trap 'cleanup; exit 143' TERM

./run.sh & wait $!
