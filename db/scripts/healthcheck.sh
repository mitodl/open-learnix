#!/usr/bin/env bash

set -e

bin_path="$(dirname "${BASH_SOURCE[0]}")"

function check_db_exists() {
  local db_name="$1"

  local result
  result="$(psql -U postgres -c "select exists(SELECT datname FROM pg_catalog.pg_database WHERE lower(datname) = lower('$db_name'));" --csv -t)"

  if [[ "$result" == "f" ]]; then
    echo "Database $db_name doesn't exist yet"
    exit 1
  else
    echo "Database $db_name exists"
  fi
}

# load array into a bash array
# output each entry as a single line json
readarray databases < <(yq -o=j -I=0 '.databases[]' "$bin_path/databases.yml" )

for database in "${databases[@]}"; do
    # parse the individual db
    db_name=$(echo "$database" | yq '.name' -)

    check_db_exists "$db_name"
done

exit 0
