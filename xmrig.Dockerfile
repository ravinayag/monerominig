FROM alpine

LABEL maintainer="ravinayag <ravinayag@gmail.com>"

ARG VERSION=6.7.1
    
RUN set -xe;\
    echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories; \
    apk update; \
    apk add util-linux build-base cmake libuv-static libuv-dev openssl-dev hwloc-dev@testing; \
    wget https://github.com/xmrig/xmrig/archive/v${VERSION}.tar.gz; \
    tar xf v${VERSION}.tar.gz; \
    mkdir -p xmrig-${VERSION}/build; \
    cd xmrig-${VERSION}/build; \
    cmake .. -DCMAKE_BUILD_TYPE=Release -DUV_LIBRARY=/usr/lib/libuv.a;\
    make -j $(nproc); \
    cp xmrig /usr/local/bin/xmrig;\
    rm -rf xmrig* *.tar.gz; \
    apk del build-base; \
    apk del openssl-dev;\ 
    apk del hwloc-dev; \
    apk del cmake; \
    apk add hwloc@testing;

ENV POOL_USER="49szjjsAJxbdQnYTB4U5miTPx18FQAS3eSckd6ZArJtu429oHXtLa485G45CWPXuP2SX5fsNQhSgw4ALKGWdeShfU8gFyFZ" \
    POOL_PASS="" \
    POOL_URL="us-west.minexmr.com:443" \
    DONATE_LEVEL=5 \
    PRIORITY=0 \
    THREADS=0

ADD entrypoint.sh /entrypoint.sh
WORKDIR /tmp
EXPOSE 8000
CMD ["/entrypoint.sh"]
