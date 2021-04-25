FROM alpine:latest

WORKDIR /srv/miner

ENV XMRIG_CORE="https://cdn.imbytecat.com/xmrig/6.12.1/xmrig-6.12.1-linux-amd64"
ENV INSTALLER="https://raw.githubusercontent.com/imByteCat/easy-miner/main/install.sh"
ENV OPTS=""

RUN apk update && \
    apk add ca-certificates && \
    update-ca-certificates && \
    apk --no-cache add openssl && \
    wget --no-check-certificate ${XMRIG_CORE} -O miner && \
    wget --no-check-certificate ${INSTALLER} -O install.sh && \
    chmod +x ./install.sh

CMD ./install.sh ${OPTS}
