#!/bin/sh

[ -L "$0" ] && SCRIPT_FILE=$(readlink -f "$0") && SCRIPT_DIR=$(dirname "$SCRIPT_FILE")
[ ! -L "$0" ] && SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd) && SCRIPT_FILE="$SCRIPT_DIR/$(basename "$0")"
. "$SCRIPT_DIR/common.sh"

PYDOCK_CONFIG_FILE="$SCRIPT_DIR/$PYDOCK_CONFIG_FILE"
if [ ! -f "$PYDOCK_CONFIG_FILE" ]; then
  echo "LOCAL_TNS_ADMIN=" >> "$PYDOCK_CONFIG_FILE"
fi

DOCKER_CLI_EXPERIMENTAL=enabled \
  docker buildx build \
  --platform "$IMAGE_PLATFORM" \
  -t "$IMAGE_NAME:$IMAGE_TAG" \
  --load \
  "$@" \
  .