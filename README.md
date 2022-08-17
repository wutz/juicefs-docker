# Docker Image packaging for JuiceFS with Ceph

In some environments where ceph rados is used, but there is no dynamic library for rados corresponding version dependencies, juicefs cannot work directly. In this case, you can use the container with ceph dynamic library to mount juicefs and then pass the mount point to the host.

## How to use

You can [use JuiceFS on Docker](https://juicefs.com/docs/community/juicefs_on_docker/), 
or mount JuiceFS to the host:

```sh
$ sudo mkdir /jfs

$ sudo docker run 
    --name juicefs \
    --net host \
    -v /etc/tikv:/etc/tikv \
    -v /etc/ceph:/etc/ceph \
    -v /var/jfsCache:/var/jfsCache \
    --mount type=bind,source=/jfs,target=/jfs,shared \
    ghcr.io/wutz/juicefs:1.0-pacific \
         mount \
         "tikv://192.168.1.101:2379,192.168.1.102:2379,192.168.1.103:2379/jfs?ca=/etc/tikv/ca.crt&cert=/etc/tikv/client.crt&key=/etc/tikv/client.key" \
         /jfs

$ df -h /jfs
```

> or using podman to run in rootless.

## How to build

```sh
$ ./build.sh
```

or

```sh
$ ./build-ceph.sh

# Your may be need to set up https_proxy in places where the network is restricted.
#export https_proxy=http://127.0.0.1:1080
$ ./download.sh

$ ./build-juicefs.sh
```
