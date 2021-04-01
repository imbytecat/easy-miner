FROM alpine:latest

WORKDIR /srv/miner

ENV INSTALL_SHELL="https://raw.githubusercontent.com/imByteCat/easy-miner/main/install.sh"
ENV XMRIG_BIN="https://cdn.imbytecat.com/xmrig/6.10.0/xmrig-6.10.0-linux-amd64"
ENV OPTS=""

RUN apk update && \
    apk add ca-certificates && \
    update-ca-certificates && \
    apk --no-cache add openssl && \
    wget --no-check-certificate ${INSTALL_SHELL} && \
    wget --no-check-certificate ${XMRIG_BIN} -O miner && \
    chmod +x ./install.sh

CMD ./install.sh ${OPTS}
