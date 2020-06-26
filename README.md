## Create primary

https://raw.githubusercontent.com/2ndQuadrant/repmgr/master/repmgr.conf.sample

Update postgresql.conf add

shared_preload_libraries = 'repmgr'

```
createuser --superuser repmgr && createdb --owner=repmgr repmgr && psql -c "ALTER USER repmgr SET search_path TO repmgr, public;"
$(command -v repmgrd) -f repmgr.conf --daemonize=true
```

## Clone and start node2 node3
```
docker-compose exec -u postgres node_2 bash
repmgr -h node_1 -U repmgr -d repmgr -f repmgr.conf standby clone -F &&\
pg_ctl start &&\
repmgr -f repmgr.conf standby register -F &&\
$(command -v repmgrd) -f repmgr.conf --daemonize=true
```



```
docker-compose exec -u postgres node_3 bash
repmgr -h node_1 -U repmgr -d repmgr -f repmgr.conf standby clone -F &&\
pg_ctl start &&\
repmgr -f repmgr.conf standby register -F &&\
$(command -v repmgrd) -f repmgr.conf --daemonize=true
```

```
repmgr -f repmgr.conf service status
```

