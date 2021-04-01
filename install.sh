#!/bin/sh

# variables
XMRIG_CORE="https://cdn.imbytecat.com/xmrig/6.10.0/xmrig-6.10.0-linux-amd64"
SERVICE=false
POOL="xmr.minecraftbe.org:25565"
WORKER=$(date "+%Y.%m.%d_%H.%M.%S")
DONATE=0
BACKGROUND=true
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
    -s | --service)
        shift
        SERVICE="$1"
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

mkdir -p /srv/miner
cd /srv/miner
if [ ! -f "miner" ]; then
    wget --no-check-certificate ${XMRIG_CORE} -O miner
fi
chmod +x miner

# prepare config
rm -f "config.json"
cat >"config.json" <<EOF
{
    "autosave": true,
    "background": ${BACKGROUND},
    "randomx": {
        "1gb-pages": true
    },
    "cpu": {
        "enabled": true,
        "huge-pages": true,
        "max-threads-hint": ${USEAGE}
    },
    "donate-level": ${DONATE},
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

# create a service
if [${SERVICE}]; then
    cat >"/etc/systemd/system/miner.service" <<EOF
[Unit]
Description=Miner Service
After=network.target syslog.target
Wants=network.target

[Service]
Type=forking
ExecStart=/srv/miner/miner
KillMode=process
Restart=on-failure
RestartSec=5s

[Install]
WantedBy=multi-user.target
EOF
    systemctl daemon-reload
    systemctl start miner
    systemctl enable miner
else
    exec /srv/miner/miner
fi
