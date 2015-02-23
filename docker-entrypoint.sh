#!/bin/bash

set -eo pipefail

if [ "$1" = 'nginx' ]; then
  export ETCD_PORT=${ETCD_PORT:-4001}
  export HOST_IP=${HOST_IP:-172.17.42.1}
  export ETCD=$HOST_IP:4001

  echo "[nginx] booting container. ETCD: $ETCD"

  confd -interval 10 -backend etcd -node $ETCD -config-file /etc/confd/conf.d/nginx.toml &

  exec "$@"
fi

exec "$@"
