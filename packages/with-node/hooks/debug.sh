#!/bin/bash
# set -e: exit asap if a command exits with a non-zero status
set -e
trap ctrl_c INT
function ctrl_c() {
  exit 0
} 

source hooks/.env.sh

CHROMIUM_VERSION=$(docker container run --rm --entrypoint "" ${REGISTRY}/${IMAGE_NAME}:${CONTEXT} chromium-browser --version)
TAG=${CHROMIUM_VERSION:9:2}
NODE_VERSION=$(docker container run --rm --entrypoint "" ${REGISTRY}/${IMAGE_NAME}:${CONTEXT} node --version)
YARN_VERSION=$(docker container run --rm --entrypoint "" ${REGISTRY}/${IMAGE_NAME}:${CONTEXT} yarn --version)

# Open Remote Debugging for test site

echo Version: ${CHROMIUM_VERSION} node@${NODE_VERSION} yarn@${YARN_VERSION}
echo docker container run -d -p ${DEBUG_PORT}:9222 --rm --name=${IMAGE_NAME}_debug ${REGISTRY}/${IMAGE_NAME}:${CONTEXT} chromium-browser --headless --use-gl=swiftshader --disable-software-rasterizer --disable-dev-shm-usage --no-sandbox --remote-debugging-address=0.0.0.0 --remote-debugging-port=${DEBUG_PORT} ${TEST_URL}
docker container run -d -p ${DEBUG_PORT}:9222 --rm --name=${IMAGE_NAME}_debug ${REGISTRY}/${IMAGE_NAME}:${CONTEXT} chromium-browser --headless --use-gl=swiftshader --disable-software-rasterizer --disable-dev-shm-usage --no-sandbox --remote-debugging-address=0.0.0.0 --remote-debugging-port=${DEBUG_PORT} ${TEST_URL}
