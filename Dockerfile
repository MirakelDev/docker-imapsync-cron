FROM debian:bookworm

RUN set -xe && \
    apt-get update \
    && apt-get install -y \
    cron \
    gettext-base \
    libauthen-ntlm-perl \
    libcgi-pm-perl \
    libcrypt-openssl-rsa-perl \
    libdata-uniqid-perl \
    libencode-imaputf7-perl \
    libfile-copy-recursive-perl \
    libfile-tail-perl \
    libio-compress-perl \
    libio-socket-ssl-perl \
    libio-socket-inet6-perl \
    libio-tee-perl \
    libhtml-parser-perl \
    libjson-webtoken-perl \
    libmail-imapclient-perl \
    libnet-server-perl \
    libparse-recdescent-perl \
    libmodule-scandeps-perl \
    libpar-packer-perl \
    libproc-processtable-perl \
    libreadonly-perl \
    libregexp-common-perl \
    libsys-meminfo-perl \
    libterm-readkey-perl \
    libtest-mockobject-perl \
    libtest-pod-perl \
    libunicode-string-perl \
    liburi-perl  \
    libwww-perl \
    procps \
    wget \
    make \
    cpanminus \
    lsof \
    ncat \
    openssl \
    ca-certificates \
    iputils-ping \
    bind9-host \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /etc/cron.*/* \
    && cpanm IO::Socket::SSL

COPY imapsync /usr/bin/imapsync
COPY run_imapsync.sh /usr/bin/run_imapsync.sh
COPY crontab.template /crontab.template
COPY entrypoint.sh /entrypoint.sh

# Adding executable permissions
RUN chmod +x /entrypoint.sh /usr/bin/run_imapsync.sh /usr/bin/imapsync

# Run Imapsync test
RUN set -xe \
    && /usr/bin/imapsync --testslive

# Default environment variables
ENV CRON_SCHEDULE="0 * * * *" \
    HOST1="test1.lamiral.info" \
    USER1="test1" \
    PASSWORD1="secret1" \
    OTHER1="" \
    HOST2="test2.lamiral.info" \
    USER2="test2" \
    PASSWORD2="secret2" \
    OTHER2=""

ENTRYPOINT ["/entrypoint.sh"]

CMD ["cron","-f"]
