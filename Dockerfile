FROM debian:12.14@sha256:30482e873082e906a4908c10529180aefb6f77620aea7404b909829fadc5d168

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