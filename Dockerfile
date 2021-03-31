#/bin/sh

FROM alpine:latest

WORKDIR /srv/miner

ENV INSTALL_SHELL="https://raw.fastgit.org/imByteCat/easy-miner/main/install.sh"

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories && \
    apk update && \
    apk add ca-certificates && \
    update-ca-certificates && \
    apk --no-cache add openssl && \
    wget --no-check-certificate ${INSTALL_SHELL} && \
    chmod +x install.sh && \
    pwd && \
    ls

CMD ./install.sh $0 $@
