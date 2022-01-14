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

# Run e2e testing for test site

echo Version: ${CHROMIUM_VERSION} node@${NODE_VERSION} yarn@${YARN_VERSION}

echo docker container run -it --rm -v $(pwd)/${CONTEXT}/src:/usr/src/app/src --cap-add=SYS_ADMIN ${REGISTRY}/${IMAGE_NAME}:${CONTEXT} node src/useragent.js
docker container run -it --rm -v $(pwd)/${CONTEXT}/src:/usr/src/app/src --cap-add=SYS_ADMIN ${REGISTRY}/${IMAGE_NAME}:${CONTEXT} node src/useragent.js
