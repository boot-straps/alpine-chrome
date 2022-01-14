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

docker tag  ${REGISTRY}/${IMAGE_NAME}:${CONTEXT} ${REGISTRY}/${IMAGE_NAME}:${TAG}-${CONTEXT}
docker push ${REGISTRY}/${IMAGE_NAME}:${CONTEXT}
docker push ${REGISTRY}/${IMAGE_NAME}:${TAG}-${CONTEXT}
