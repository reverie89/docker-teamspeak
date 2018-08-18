## Alpine requires glibc to be present in the system below link to official repository
### https://github.com/sgerrand/alpine-pkg-glibc

FROM alpine:latest

RUN apk --no-cache add ca-certificates wget w3m curl; \
    GLIBC_VERSION="$(curl -s https://api.github.com/repos/sgerrand/alpine-pkg-glibc/releases/latest | grep '\"tag_name\":' | sed -E 's/.*\"([^\"]+)\".*/\1/')"; \
    wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub; \
    wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-${GLIBC_VERSION}.apk; \
    apk add glibc-${GLIBC_VERSION}.apk; \
    apk add --update bzip2; \
    rm -rf /tmp/* /var/tmp/* /var/cache/apk/* /var/cache/distfiles/* /glibc-${GLIBC_VERSION}.apk; \
    apk del curl

COPY bootstrap.sh /

EXPOSE 9987/udp 10011 30033

ENTRYPOINT "/bootstrap.sh"
