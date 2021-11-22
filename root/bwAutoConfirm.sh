#!/bin/bash

# This script will auto-confirm organization members, synced by of the bitwarden directory connector, when they
# were connected at least once and after having created their password

# It is intented to be run periodically by a systemctl timer

bw() {
  docker run --rm -v /root/.config:/root/.config --user "$UID" lamarmhotte/bitwarden-cli:1.19.1 "$@"
}

jq() {
  docker run --rm -v "${PWD}:/data" -i imega/jq "$@"
}

organization_id="xxxxxorg-guid-xxxx-xxxx-xxxxxxxxxxxx"
master_pwd="xxxxxxxxxxxxxxx"

session_key="$(bw unlock "$master_pwd" --raw)"
org_members="$(bw list --session $session_key org-members --organizationid $organization_id | jq -c '.[] | select( .status == 1 )' | jq -c '.id' | tr -d '"')"
for member_id in ${org_members[@]} ; do
        bw confirm --session $session_key org-member $member_id --organizationid $organization_id
done
