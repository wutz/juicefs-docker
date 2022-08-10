# Docker Image packaging for JuiceFS with Ceph

## Pull

```sh
$ docker pull ghcr.io/wutz/ceph:16.2-focal

$ docker pull ghcr.io/wutz/juicefs:1.0-pacific
```

## Build

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
