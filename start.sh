#!/bin/sh
/app/DockerEntrypoint.sh &
sleep 3
exec /usr/local/bin/cloudflared tunnel --no-autoupdate run --token "$TUNNEL_TOKEN"
