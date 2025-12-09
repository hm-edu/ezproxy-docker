FROM debian:12.12@sha256:7e5bc0e499a8d50cb1e32287944a90b9ec8fd7d500673e75daff3f52882f5798

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