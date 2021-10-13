#!/bin/bash

HEADER="Authorization: Bearer $1"
RUNNER_VERSION=$(curl -H "$HEADER" https://api.github.com/repos/actions/runner/tags | grep -o '"name": "[^"]*' | grep -o '[^v]*$' -m1)
VERSION=$(curl -H "$HEADER" https://api.github.com/repos/GVLTodorov/Runner/tags | grep -o '"name": "[^"]*' | grep -o '[^v]*$' -m1)

echo "${RUNNER_VERSION}"
echo "${VERSION}"

if [ "$RUNNER_VERSION" != "$VERSION" ]; then
        echo "Not Equal ..."
        echo "Making new version ..."
curl -X POST -H "Content-Type:application/json" \
-H "$HEADER" https://api.github.com/repos/GVLTodorov/Runner/releases \
-d '{"tag_name":"v'${RUNNER_VERSION}'","target_commitish": "main","name": "v'${RUNNER_VERSION}'","body": "Description","draft": false,"prerelease": false}'
else
        echo "Equal ..."
fi
