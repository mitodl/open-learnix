#!/usr/bin/env bash

set -eo

export OL_SSL_CERT="$(cat /run/secrets/ol-ssl-cert)"
export OL_SSL_KEY="$(cat /run/secrets/ol-ssl-key)"

# call the entrypoint defined in the original Dockerfile
bash /docker-entrypoint.sh "$@"
