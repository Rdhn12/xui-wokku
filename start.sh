#!/bin/sh

/app/DockerEntrypoint.sh &

sleep 3

if [ -z "$TUNNEL_TOKEN" ]
; then
    echo "ERROR: Variabel TUNNEL_TOKEN belum diisi!"
    exit 1
fi

exec /usr/local/bin/cloudflared tunnel --no-autoupdate run --token "$TUNNEL_TOKEN"
