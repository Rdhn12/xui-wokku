#!/bin/sh
XRAY_BIN=$(find / -type f -name "xray*" -executable 2>/dev/null | head -n 1)
"$XRAY_BIN" -c /app/config.json &
exec /usr/local/bin/cloudflared tunnel --no-autoupdate run --token "$TUNNEL_TOKEN"
