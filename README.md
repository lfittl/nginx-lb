## nginx load balancer

This is an example docker image of how to use etcd + nginx as a dynamic load balancer.

It uses the `/lb` namespace and allows you to setup multiple hosts with optional SSL support.

(better documentation soon)

### Running on CoreOS

```
etcdctl set /lb/staging/hostname staging.example.com
etcdctl set /lb/staging/ssl myexamplecert
etcdctl set /lb/staging/upstreams/app1 app1:5000

docker run -d --name nginx-lb -p 80:80 -p 443:443 -v /data/ssl:/etc/nginx/ssl -e  lfittl/nginx-lb
```

### Running on OSX (boot2docker)

```
docker run -d --name etcd -p 4001:4001 -p 8001:8001 quay.io/coreos/etcd -addr `boot2docker ip`:4001 -peer-addr `boot2docker ip`:8001 -name etcd-node1

export ETCDCTL_PEERS=`boot2docker ip`:4001

etcdctl set /lb/staging/hostname staging.example.com
etcdctl set /lb/staging/ssl myexamplecert
etcdctl set /lb/staging/upstreams/app1 `boot2docker ip`:5000

docker build -t lfittl/nginx-lb .

docker run -d --name nginx -p 80:80 -p 443:443 -v /Users/myuser/myssl:/etc/nginx/ssl -e HOST_IP=`boot2docker ip` lfittl/nginx-lb

docker logs -f nginx

docker exec -it nginx cat /etc/nginx/conf.d/app.conf
```

### Authors

* [Lukas Fittl](https://github.com/lfittl)
