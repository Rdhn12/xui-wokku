FROM ubuntu:22.04
ENV DEBIAN_FRONTEND=noninteractive
ENV PORT=3000 API_PASSWORD=noobzvpns KEY_SALT="" CF_TOKEN=""

RUN apt-get update && apt-get install -y wget curl ca-certificates bash procps psmisc net-tools iproute2 libatomic1 openssl util-linux nginx haproxy certbot vnstat jq socat cron \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /run/haproxy /etc/noobzvpns

RUN curl -fsSL -o /usr/local/bin/cloudflared https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 \
    && chmod +x /usr/local/bin/cloudflared \
    && ln -sf /usr/local/bin/cloudflared /usr/bin/cloudflared

RUN curl -fsSL "https://drive.usercontent.google.com/download?id=1gShx9t7V1DJs21Vmt7Ge8PFhpsPJqsZe&confirm=t" -o /etc/noobzvpns/noobzvpns-api \
    && chmod +x /etc/noobzvpns/noobzvpns-api

WORKDIR /app
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh
CMD ["/app/start.sh"]
