#!/user/bin/env bash
#
# library of bash functions

function ol_dc_cmd() {
  local compose_file
  compose_file="$1/docker-compose.yml"

  shift 1

  COMPOSE_FILE=$compose_file docker compose "$@"
}
