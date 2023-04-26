#!/bin/sh

[ -L "$0" ] && SCRIPT_FILE=$(readlink -f "$0") && SCRIPT_DIR=$(dirname "$SCRIPT_FILE")
[ ! -L "$0" ] && SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd) && SCRIPT_FILE="$SCRIPT_DIR/$(basename "$0")"
. "$SCRIPT_DIR/common.sh"

PYDOCK_CONFIG_FILE="$SCRIPT_DIR/$PYDOCK_CONFIG_FILE"
[ -f "$PYDOCK_CONFIG_FILE" ] && . ${PYDOCK_CONFIG_FILE}

LOCAL_TNS_ADMIN="${LOCAL_TNS_ADMIN:-$TNS_ADMIN}"
[ -z "$LOCAL_TNS_ADMIN" ] && echo "Please, specify 'LOCAL_TNS_ADMIN' parameter in '$PYDOCK_CONFIG_FILE'" >&2 && exit 1

[ -z "$( docker images -q "$IMAGE_NAME:$IMAGE_TAG" )" ] \
  && echo "Docker image [$IMAGE_NAME:$IMAGE_TAG] not found; please, run command 'make build' first" >&2 && exit 1

PYDOCK_RUN_FLAG_INTERACTIVE=${PYDOCK_RUN_FLAG_INTERACTIVE:-"true"}
docker run $( [ "$PYDOCK_RUN_FLAG_INTERACTIVE" = "true" ] && echo "-it" ) \
       --rm \
       --platform "$IMAGE_PLATFORM" \
       -v "$(pwd)":/work \
       -v "$LOCAL_TNS_ADMIN":/etc/oracle/instantclient/network/admin:Z,ro \
       -e GIT_USER_NAME="$(git config --get user.name)" \
       -e GIT_USER_EMAIL="$(git config --get user.email)" \
       "$IMAGE_NAME:$IMAGE_TAG" \
       sqlplus "$@"§