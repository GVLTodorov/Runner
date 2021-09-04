#!/bin/bash

if [ -z ${TOKEN+x} ]; then
  echo "TOKEN environment variable is not set"
  exit 1
fi

if [ -z ${REPOSITORY+x} ]; then
  echo "REPOSITORY environment variable is not set."
  exit 1
fi

cd /home/1000/actions-runner

./config.sh --url $REPOSITORY --token $TOKEN --name $NAME --labels $LABEL --work ${DIR}

cleanup() {
    echo "Removing runner..."
    ./config.sh remove --unattended --token ${TOKEN}
}

trap 'cleanup; exit 130' INT
trap 'cleanup; exit 143' TERM

./run.sh & wait $!
