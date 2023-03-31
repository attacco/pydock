#!/bin/sh

export DOCKER_CLI_EXPERIMENTAL=enabled

docker buildx build \
  --platform linux/amd64 \
  -t pydock:latest \
  --load \
  .