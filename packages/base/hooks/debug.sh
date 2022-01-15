#!/bin/bash
# set -e: exit asap if a command exits with a non-zero status
set -e
trap ctrl_c INT
function ctrl_c() {
  exit 0
} 

source hooks/.env.sh

ALPINE_VERSION=$(docker container run --rm --entrypoint "" ${REGISTRY}/${IMAGE_NAME}:${CONTEXT:-latest} cat /etc/alpine-release)
CHROMIUM_VERSION=$(docker container run --rm --entrypoint "" ${REGISTRY}/${IMAGE_NAME}:${CONTEXT:-latest} chromium-browser --version)
TAG=${CHROMIUM_VERSION:9:2}

# Open Remote Debugging for test site

echo Version: alpine@${ALPINE_VERSION} ${CHROMIUM_VERSION}
echo docker container run -d -p ${DEBUG_PORT}:9222 --rm --name=${IMAGE_NAME}_debug ${REGISTRY}/${IMAGE_NAME}:${CONTEXT:-latest} --no-sandbox --remote-debugging-address=0.0.0.0 --remote-debugging-port=${DEBUG_PORT} ${TEST_URL}
docker container run -d -p ${DEBUG_PORT}:9222 --rm --name=${IMAGE_NAME}_debug ${REGISTRY}/${IMAGE_NAME}:${CONTEXT:-latest} --no-sandbox --remote-debugging-address=0.0.0.0 --remote-debugging-port=${DEBUG_PORT} ${TEST_URL}
