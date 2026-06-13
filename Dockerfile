FROM debian:12.14@sha256:49ba348354a28e39c70beffd6cf43bdb8d55d81ce4b746b0428717d054b8bbc4

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