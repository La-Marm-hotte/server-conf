#!/bin/bash

upgrade_bitwarden()
{
  /apps/bitwarden/bitwarden.sh updateself
  /apps/bitwarden/bitwarden.sh update
}

upgrade_keycloak()
{
  /usr/local/bin/docker-compose -f "/apps/keycloak/docker-compose.yml" pull
  /usr/local/bin/docker-compose -f "/apps/keycloak/docker-compose.yml" down
  /usr/local/bin/docker-compose -f "/apps/keycloak/docker-compose.yml" up -d
}

upgrade_nginx()
{
  /usr/local/bin/docker-compose -f "/apps/nginx/docker-compose.yml" pull
  /usr/local/bin/docker-compose -f "/apps/nginx/docker-compose.yml" down
  /usr/local/bin/docker-compose -f "/apps/nginx/docker-compose.yml" up -d
}

upgrade_openldap()
{
  /usr/local/bin/docker-compose -f "/apps/openldap/docker-compose.yml" pull
  /usr/local/bin/docker-compose -f "/apps/openldap/docker-compose.yml" down
  /usr/local/bin/docker-compose -f "/apps/openldap/docker-compose.yml" up -d
}

upgrade_letsencrypt()
{
  /usr/bin/docker pull certbot/certbot:latest
}

upgrade_wordpress()
{
  /usr/local/bin/docker-compose -f "/apps/wordpress/docker-compose.yml" pull
  /usr/local/bin/docker-compose -f "/apps/wordpress/docker-compose.yml" down
  /usr/local/bin/docker-compose -f "/apps/wordpress/docker-compose.yml" up -d
}

clean()
{
  /usr/bin/docker image prune -f
}

run()
{
  upgrade_bitwarden
  upgrade_keycloak
  upgrade_letsencrypt
  upgrade_nginx
  upgrade_openldap
  upgrade_wordpress
  clean
  exit 0
}

run "$@"

