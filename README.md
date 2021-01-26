# Instructions

Les applications sont installées dans `/apps`.
Elles sont gérées par docker et docker-compose.

## Gestion des containeurs
Docker
- dépôt : https://github.com/docker/cli
- doc : https://docs.docker.com/

## Coffre-fort
Bitwarden
- dépôt : https://github.com/bitwarden/server
- doc : https://bitwarden.com/help/article/install-on-premise/

On utilise BitBetter pour créer une organisation : https://github.com/alexyao2015/BitBetter

## Proxy inversé
Nginx
- dépôt : http://hg.nginx.org/nginx/
- doc : https://nginx.org/en/docs/

## Certificats SSL
Let's encrypt (docker)
- On utilise Systemd pour gérer l'exécution de l'image docker :
  - systemctl enable letsencrypt@xxxxx.service
  - systemctl start letsencrypt@xxxxx.service
  - systemctl status -n 20 letsencrypt@xxxxx.service
- doc : https://certbot.eff.org/docs/install.html#running-with-docker

## Annuaire
OpenLDAP
- On utilise l'image docker de osixia
- dépôt : https://github.com/osixia/docker-openldap
- doc : https://www.openldap.org/doc/admin24/

## Authentification et gestion des utilisateurs
Keycloak
- dépôt : https://github.com/keycloak/keycloak
- doc : https://www.keycloak.org/documentation.html

## Moteur de site web
Wordpress
- dépôt : https://github.com/WordPress/WordPress
- doc : https://docs.docker.com/compose/wordpress/
