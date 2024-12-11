#!/bin/bash
set -e

function create_user_and_db() {
  local db_user="$1"
  local db_password="$2"
  local db_name="$3"

  psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
  DO
  \$do\$
  BEGIN
     IF EXISTS (
        SELECT FROM pg_catalog.pg_roles
        WHERE  rolname = '${db_user}') THEN

        RAISE NOTICE 'Role "${db_user}" already exists. Skipping.';
     ELSE
        CREATE ROLE my_user LOGIN PASSWORD '${db_password}';
     END IF;
  END
  \$do\$;

  SELECT 'CREATE DATABASE ${db_name}'
      WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = '${db_name}');\gexec

  GRANT ALL PRIVILEGES ON DATABASE ${db_name} TO postgres;
EOSQL
}


create_user_and_db "keycloak" "password" "keycloak"
