# Docker Image packaging for JuiceFS with Ceph

In some environments where ceph rados is used, but there is no dynamic library for rados corresponding version dependencies, juicefs cannot work directly. In this case, you can use the container with ceph dynamic library to mount juicefs and then pass the mount point to the host.

## How to use

Format:

```sh
docker run \
    --rm \
    --net host \
    -v /etc/ceph:/etc/ceph \
    ghcr.io/wutz/juicefs:1.1-quincy \
        format \
        --storage ceph \
        --bucket ceph://<pool-name> \
        --access-key <cluster-name> \
        --secret-key <user-name> \
        redis://<username>:<password>@<redis-server-ip>:6379/1 \
        jfs
```

> https://juicefs.com/docs/community/reference/how_to_set_up_object_storage#ceph-rados


Mount:

```sh
mkdir /jfs

docker run 
    --name juicefs \
    --net host \
    -v /etc/ceph:/etc/ceph \
    -v /var/jfsCache:/var/jfsCache \
    --mount type=bind,source=/jfs,target=/jfs,bind-propagation=shared \
    --privileged \
    ghcr.io/wutz/juicefs:1.1-quincy \
         mount \
         redis://<username>:<password>@<redis-server-ip>:6379/1 \
         /jfs

df -h /jfs
```

## How to build

```sh
make image
make push
```
