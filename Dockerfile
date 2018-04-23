## Alpine requires glibc to be present in the system below link to official repository
### https://github.com/sgerrand/alpine-pkg-glibc

FROM alpine:latest

ENV GLIBC_VERSION='2.26-r0'

RUN \
    apk --no-cache add ca-certificates wget w3m && \
    wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://raw.githubusercontent.com/sgerrand/alpine-pkg-glibc/master/sgerrand.rsa.pub && \
    wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-${GLIBC_VERSION}.apk && \
    apk add glibc-${GLIBC_VERSION}.apk && \
    apk add --update bzip2 && \
    rm -rf /tmp/* /var/tmp/* /var/cache/apk/* /var/cache/distfiles/* /glibc-${GLIBC_VERSION}.apk && \
    TS3_VERSION="$(w3m -dump https://www.teamspeak.com/downloads | grep -m 1 'Server 64-bit ' | awk '{print $NF}')" && \
    wget http://dl.4players.de/ts/releases/${TS3_VERSION}/teamspeak3-server_linux_amd64-${TS3_VERSION}.tar.bz2 -O /tmp/teamspeak.tar.bz2 && \
    apk del w3m

COPY bootstrap.sh /

EXPOSE 9987/udp 10011 30033

ENTRYPOINT "/bootstrap.sh"
