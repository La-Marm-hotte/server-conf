alias certificates='/usr/bin/docker run --rm --name certbot -v "/apps/letsencrypt/etc:/etc/letsencrypt" certbot/certbot:latest certificates'

removecert() {
  /usr/bin/docker run --rm --name certbot -v "/apps/letsencrypt/etc:/etc/letsencrypt" certbot/certbot:latest delete --cert-name "$1"
}
