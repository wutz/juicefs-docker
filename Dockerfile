FROM ubuntu:22.04 as base

RUN set -eux; \
	apt update; \
	apt install -y wget gnupg; \
	wget -q -O- 'https://download.ceph.com/keys/release.asc' | apt-key add -; \
	echo 'deb http://mirrors.ustc.edu.cn/ceph/debian-quincy/ jammy main' > /etc/apt/sources.list.d/ceph.list; \
    	apt update; \
	apt install -y librados2 fuse; \
	rm -rf /var/lib/apt/lists/*

FROM base as build

ENV GOPROXY=https://goproxy.cn
ENV PATH /usr/local/go/bin:$PATH
ENV GOVERSION=go1.21.11
ENV JFSVERSION=v1.1.2

WORKDIR /tmp

RUN set -eux; \
	apt update; \
	apt install -y librados-dev make gcc; \
	wget https://go.dev/dl/${GOVERSION}.linux-amd64.tar.gz; \
	tar -C /usr/local -xzf ${GOVERSION}.linux-amd64.tar.gz; \
	wget https://github.com/juicedata/juicefs/archive/refs/tags/${JFSVERSION}.tar.gz; \
	mkdir /usr/local/jfs; \
	tar -C /usr/local/jfs -xzf ${JFSVERSION}.tar.gz --strip-components 1; \
	cd /usr/local/jfs; \
	make juicefs.ceph

FROM base

COPY --from=build /usr/local/jfs/juicefs.ceph /usr/local/bin/juicefs

ENTRYPOINT ["/usr/local/bin/juicefs"]
