#!/bin/sh

docker run -it --rm --platform linux/amd64 -v "$(pwd)":/work pydock:latest python3 "$@"
