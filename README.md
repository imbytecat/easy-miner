# Easy Miner

> An all-in-one solution for mining cryptocurrencies.

![](https://github.com/imByteCat/easy-miner/actions/workflows/build-xmrig.yml/badge.svg)  ![](https://github.com/imByteCat/easy-miner/actions/workflows/build-docker-image.yml/badge.svg)

## Installing

```bash
wget --no-check-certificate https://raw.fastgit.org/imByteCat/easy-miner/main/install.sh && bash install.sh
```

## Options

⚠️ Note: You **cannot** run the miner as a service if background is set to `false`

- `-b` or `--background`, background, default `true`
- `-d` or `--donate`, donate level, default `0`
- `-p` or `--pool`, pool ip, default `xmr.minecraftbe.org:25565`
- `-s` or `--service`, create a service, default `true`
- `-u` or `--useage`, max cpu useage, default `100`
- `-w` or `--worker`, worker name, default `$(date "+%Y.%m.%d_%H.%M.%S")`

## Docker

```shell
docker run -e OPTS="-s false" imbytecat/easy-miner:latest
```

