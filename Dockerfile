FROM ghcr.io/mhsanaei/3x-ui:latest

RUN wget -qO /usr/local/bin/cloudflared https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 \
    && chmod +x /usr/local/bin/cloudflared

COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 2053

ENTRYPOINT ["/start.sh"]
