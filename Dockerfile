FROM alpine:latest

ENV XMRIG_BIN="https://cdn.imbytecat.com/xmrig/6.10.0/xmrig-6.10.0-linux-x64"

RUN wget --no-check-certificate ${XMRIG_BIN} -O miner

ENTRYPOINT [ "miner" ]

CMD [ "executable" ]