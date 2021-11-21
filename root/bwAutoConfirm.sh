#!/bin/bash

bw() {
  docker run --rm -it -v /root/.config:/root/.config --user "$UID" lamarmhotte/bitwarden-cli:1.19.1 "$@"
}

jq() {
  docker run --rm -i -v "${PWD}:/data" imega/jq "$@"
}

organization_id="example-org"
session_key="$(bw unlock --raw)"
org_members="$(bw list --session $session_key org-members --organizationid $organization_id | jq -c '.[] | select( .status == 1 )' | jq -c '.id' | tr -d '"')"
for member_id in ${org_members[@]} ; do
        bw confirm --session $session_key org-member $member_id --organizationid $organization_id
done
