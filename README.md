# Instructions

Les applications sont installées dans `/apps`.
Elles sont gérées par docker et docker-compose.

## Gestion des containeurs
Docker (debian)
- dépôt : https://github.com/docker/cli
- doc : https://docs.docker.com/

## Coffre-fort
Bitwarden (docker)
- dépôt : https://github.com/bitwarden/server
- doc : https://bitwarden.com/help/article/install-on-premise/

On utilise BitBetter pour créer une organisation : https://github.com/alexyao2015/BitBetter

On utilise Bitwarden Directory Connector (bwdc), via une tâche planifiée (cron) pour synchroniser les utilisateurs depuis LDAP : https://bitwarden.com/help/article/directory-sync/

## Proxy inversé
Nginx (docker)
- dépôt : http://hg.nginx.org/nginx/
- doc : https://nginx.org/en/docs/

## Certificats SSL
Let's encrypt (docker)
- On utilise Systemd pour gérer l'exécution de l'image docker :
  - systemctl start letsencrypt@xxxxx.service
  - systemctl status -n 20 letsencrypt@xxxxx.service
- doc : https://certbot.eff.org/docs/install.html#running-with-docker

Commandes utiles :
```bash
# lister tous les certificats
certificates
# supprimer un certificat
removecert <domaine>
```

## Annuaire
OpenLDAP (docker)
- On utilise l'image docker de osixia
- dépôt : https://github.com/osixia/docker-openldap
- doc : https://www.openldap.org/doc/admin24/
- doc : https://wiki.debian.org/LDAP/OpenLDAPSetup

## Authentification et gestion des utilisateurs
Keycloak (docker)
- dépôt : https://github.com/keycloak/keycloak
- doc : https://www.keycloak.org/documentation.html

## Moteur de site web
Wordpress (docker)
- dépôt : https://github.com/WordPress/WordPress
- doc : https://docs.docker.com/compose/wordpress/

## Mises à jour automatiques
Unattended-upgrades (debian)
- dépôt: https://github.com/mvo5/unattended-upgrades

## Blocage des IP
Fail2ban (debian)
- dépôt : https://github.com/fail2ban/fail2ban

## Envoyer un courriel
### Avec s-nail (méthode préférée)

```bash
echo -e "contenu du mail" | s-nail -s "sujet" user@example.org
```

### Avec msmtp

```bash
/usr/sbin/sendmail user@example.org << EOF | cat
Subject: test

Contenu du mail
EOF
```

