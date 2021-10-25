#!/bin/bash

echo "Entrypoint script ..."

if [ -z ${TOKEN+x} ]; then
  echo "TOKEN environment variable is not set"
  exit 1
fi

if [ -z ${REPOSITORY+x} ]; then
  echo "REPOSITORY environment variable is not set."
  exit 1
fi

echo "Preparing ..."

API_VERSION=v3
API_HEADER="Accept: application/vnd.github.${API_VERSION}+json"
AUTH_HEADER="Authorization: Bearer ${TOKEN}"

API=https://api.github.com/repos
AOO="$(echo "${REPOSITORY}" | cut -d/ -f4)"
RNAME="$(echo "${REPOSITORY}" | cut -d/ -f5)"

URL="${API}/${AOO}/${RNAME}/actions/runners/registration-token"

echo "Using ${URL} ..."
echo "Obtain Token..."

RTOKEN="$(curl -XPOST -fsSL \
  -H "${AUTH_HEADER}" \
  -H "${API_HEADER}" \
  "${URL}" \
| jq -r '.token')"

echo "Successful ..."

echo "Configuring ..."
cd /home/docker/actions-runner

./config.sh --unattended --url "${REPOSITORY}" --token "${RTOKEN}" --name "${NAME}" --labels "${LABEL}" --work "${DIR}"

cleanup() {
    echo "Removing runner..."
    ./config.sh remove --unattended --token $RTOKEN
}

trap 'cleanup; exit 130' INT
trap 'cleanup; exit 143' TERM

./run.sh & wait $!
