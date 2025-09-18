#!/usr/bin/env bash

set -eo

export OL_SSL_CERT="$(cat /run/secrets/odl.local.crt)"
export OL_SSL_KEY="$(cat /run/secrets/odl.local.key)"

# call the entrypoint defined in the original Dockerfile
bash /docker-entrypoint.sh "$@"
