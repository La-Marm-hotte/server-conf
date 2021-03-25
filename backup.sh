#!/bin/bash

copy()
{
  local source=$1
  local dest=$2
  local path=$3
  mkdir -p "$dest/$path"
  if [[ $(file "$source/$path") == *"directory"* ]]; then
    rsync -a --delete "$source/$path/" "$dest/$path"
  else
    rsync "$source/$path" $(dirname "$dest/$path")
  fi
}

init_dir()
{
  BACKUP="/backup"
  mkdir "$BACKUP"
}

backup_bitwarden()
{
  BWDATA="/apps/bitwarden/bwdata"
  BWBACKUP="$BACKUP/bitwarden/bwdata"

  copy "$BWDATA" "$BWBACKUP" "config.yml"
  copy "$BWDATA" "$BWBACKUP" "docker/docker-compose.override.yml"
  copy "$BWDATA" "$BWBACKUP" "/env"
  copy "$BWDATA" "$BWBACKUP" "/core/attachments"
  copy "$BWDATA" "$BWBACKUP" "/mssql/data"
}

backup_keycloak()
{
  KCDATA="/apps/keycloak"
  KCBACKUP="$BACKUP/keycloak"

  copy "$KCDATA" "$KCBACKUP" "docker-compose.yml"
  copy "$KCDATA" "$KCKACKUP" "config"

  mkdir -p "$KCBACKUP/postgres"
  docker-compose -f "$KCDATA/docker-compose.yml" exec postgres pg_dump -U keycloak keycloak > "$KCBACKUP/postgres/keycloak.dump.sql"
}

backup_letsencrypt()
{
  LEDATA="/apps/letsencrypt/etc"
  LEBACKUP="$BACKUP/letsencrypt/etc"

  copy "$LEDATA" "$LEBACKUP" "config"
}

backup_nginx()
{
  NGDATA="/apps/nginx"
  NGBACKUP="$BACKUP/nginx"

  copy "$NGDATA" "$NGBACKUP" "docker-compose.yml"
  copy "$NGDATA" "$NGBACKUP" "conf.d"
}

backup_openldap()
{
  OLDATA="/apps/openldap"
  OLBACKUP="$BACKUP/openldap"

  copy "$OLDATA" "$OLBACKUP" "docker-compose.yml"
  copy "$OLDATA" "$OLBACKUP" "config"

  mkdir -p "$OLBACKUP/data"
  # see https://tylersguides.com/articles/backup-restore-openldap/
  docker-compose -f "$OLDATA/docker-compose.yml" exec openldap slapcat -n 0 > "$OLBACKUP/data/configuration.ldif"
  docker-compose -f "$OLDATA/docker-compose.yml" exec openldap slapcat -n 1 > "$OLBACKUP/data/data.ldif"
}

backup_wordpress()
{
  WPDATA="/apps/wordpress"
  WPBACKUP="$BACKUP/wordpress"

  copy "$WPDATA" "$WPBACKUP" "docker-compose.yml"
  copy "$WPDATA" "$WPBACKUP" "config"
  copy "$WPDATA" "$WPBACKUP" "wordpress"

  mkdir -p "$WPBACKUP/mysql"
  local password=$(cat "$WPDATA/config/my_env" | grep MYSQL_ROOT_PASSWORD | sed -E 's/.*=(.*)/\1/')
  docker-compose -f "$WPDATA/docker-compose.yml" exec -e MYSQL_PWD="$password" mysql mysqldump -uroot --all-databases > "$WPBACKUP/mysql/wordpress.dump.sql"
}

upload()
{
  mega-put -c /backup "/vps-backup/$(date -I)/"
}

remove_dir()
{
  rm -rf "$BACKUP"
}

run()
{
  init_dir
  backup_bitwarden
  backup_keycloak
  backup_letsencrypt
  backup_nginx
  backup_openldap
  backup_wordpress
  upload
  remove_dir
}

run "$@"
