#!/bin/bash 

export GIT_COMMIT=$(git rev-parse HEAD)
export BRANCH_NAME=$(git branch --show-current)
export GIT_COMMIT_SHORT=$(git rev-parse --short=8 HEAD)
docker build --build-arg GIT_COMMIT=$GIT_COMMIT --build-arg BRANCH_NAME=$BRANCH_NAME -t containerd-example:$GIT_COMMIT_SHORT . --no-cache

# check if we are being sourced by another script or shell
# [[ "${#BASH_SOURCE[@]}" -gt "1" ]] && { return 0; }