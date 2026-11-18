#!/bin/sh
/app/DockerEntrypoint.sh &
sleep 3
/app/x-ui setting -username admin -password admin
exec /usr/local/bin/cloudflared tunnel --no-autoupdate run --token "$TUNNEL_TOKEN"
