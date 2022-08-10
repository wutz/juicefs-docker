FROM ubuntu:20.04

RUN set -eux; \
	apt update; \
	apt install -y wget gnupg; \
	wget -q -O- 'https://download.ceph.com/keys/release.asc' | apt-key add -; \
	echo 'deb http://mirrors.ustc.edu.cn/ceph/debian-pacific/ focal main' > /etc/apt/sources.list.d/ceph.list; \
    	apt update; \
	apt install -y librados2; \
	rm -rf /var/lib/apt/lists/*
