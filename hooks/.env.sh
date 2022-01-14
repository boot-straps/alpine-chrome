#!/bin/bash
# set -e: exit asap if a command exits with a non-zero status
set -e
trap ctrl_c INT
function ctrl_c() {
  exit 0
} 

set -o allexport

IMAGE_NAME=alpine-chrome
REGISTRY=bootstraps
GIT_REPO=https://github.com/boot-straps/${IMAGE_NAME}.git
DEBUG_PORT=9222
TEST_URL=https://www.chromestatus.com/

set +o allexport
