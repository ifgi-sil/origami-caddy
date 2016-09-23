#!/bin/sh

set -euo pipefail
IFS=$'\n\t'

api_domain=${API_DOMAIN:-api.localhost}
origami_domain=${WEB_DOMAIN:-localhost}
issuer_adr=${ISSUER_ADDRESS:-off}
use_staging_ca=${USE_STAGING_CA:-}

if [[ -n "$use_staging_ca" ]]; then
  use_staging_ca="-ca \"https://acme-staging.api.letsencrypt.org/directory\""
fi

sed -i -e "s|API_DOMAIN|$api_domain|" -e "s|\.WEB_DOMAIN:|.$origami_domain:|" -e "s|\.WEB_DOMAIN|.$origami_domain|" -e "s|WEB_DOMAIN|$origami_domain|" -e "s|ISSUER_ADDRESS|$issuer_adr|" /etc/caddy/Caddyfile

execstr="/usr/bin/caddy $use_staging_ca -conf /etc/caddy/Caddyfile"

eval exec "$execstr"