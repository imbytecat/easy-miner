FROM alpine:latest

WORKDIR /srv/miner

ENV INSTALL_SHELL="https://raw.githubusercontent.com/imByteCat/easy-miner/main/install.sh"

ENV OPTS=""

RUN apk update && \
    apk add ca-certificates && \
    update-ca-certificates && \
    apk --no-cache add openssl && \
    wget --no-check-certificate ${INSTALL_SHELL} && \
    chmod +x ./install.sh

CMD ./install.sh ${OPTS}
