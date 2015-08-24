#!/bin/bash

set -eo pipefail

if [ "$1" = 'nginx' ]; then
  export ETCD_PORT=${ETCD_PORT:-2379}
  export HOST_IP=${HOST_IP:-$(ip -4 route list 0/0 | cut -d ' ' -f 3)}
  export ETCD=$HOST_IP:$ETCD_PORT

  echo "[nginx] booting container. ETCD: $ETCD"

  confd -interval 10 -backend etcd -node $ETCD -config-file /etc/confd/conf.d/nginx.toml &

  exec "$@"
fi

exec "$@"
