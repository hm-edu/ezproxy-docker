FROM debian:12.12@sha256:c66c66fac809bfb56a8001b12f08181a49b6db832d2c8ddabe22b6374264055f

RUN apt-get update \
  && apt-get -y install --no-install-recommends wget ca-certificates\
  && rm -rf /var/lib/apt/lists/*

COPY docker-run.sh /
RUN chmod +x /docker-run.sh \
    && mkdir -p /usr/local/ezproxy/config \
    && wget -O /usr/local/ezproxy/ezproxy https://help.oclc.org/@api/deki/files/9850/ezproxy-linux.bin \
    && chmod +x /usr/local/ezproxy/ezproxy
RUN apt-get purge -y ca-certificates \
    && apt-get clean autoclean autoremove -y \
    && rm -rf /var/lib/apt/lists/*

VOLUME /usr/local/ezproxy/config

CMD ["/docker-run.sh"]