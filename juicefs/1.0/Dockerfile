FROM ghcr.io/wutz/ceph:16.2-focal as build

ENV GOPROXY=https://goproxy.cn
ENV PATH /usr/local/go/bin:$PATH
WORKDIR /tmp

COPY ./go1.19.linux-amd64.tar.gz ./go1.19.linux-amd64.tar.gz
COPY ./juicefs-1.0.0.tar.gz ./juicefs-1.0.0.tar.gz

RUN set -eux; \
	apt update; \
	apt install -y librados-dev make gcc; \
	tar -C /usr/local -xzf go1.19.linux-amd64.tar.gz; \
	rm -f go1.19.linux-amd64.tar.gz; \
	tar zxvf juicefs-1.0.0.tar.gz; \
	cd juicefs-1.0.0; \
	make juicefs.ceph


FROM ghcr.io/wutz/ceph:16.2-focal

COPY --from=build /tmp/juicefs-1.0.0/juicefs.ceph /usr/local/bin/juicefs

ENTRYPOINT ["/usr/local/bin/juicefs"]
