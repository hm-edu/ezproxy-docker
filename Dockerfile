FROM debian:13.4@sha256:55a15a112b42be10bfc8092fcc40b6748dc236f7ef46a358d9392b339e9d60e8

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