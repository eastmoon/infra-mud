FROM alpine:3.14 as builder

RUN apk add --no-progress --no-cache \
    linux-headers gcc g++ clang-dev make cmake python2 bash \
    mariadb-dev mariadb-static postgresql-dev sqlite-dev sqlite-static\
    libevent-dev libevent-static libexecinfo-dev libexecinfo-static \
    openssl-dev openssl-libs-static zlib-dev zlib-static icu-dev icu-static \
    pcre-dev bison git

# Build jemalloc
WORKDIR /usr/src
RUN wget -O - https://github.com/jemalloc/jemalloc/releases/download/5.2.1/jemalloc-5.2.1.tar.bz2 | tar -xj
WORKDIR /usr/src/jemalloc-5.2.1
RUN \
    ./configure --prefix=/usr && \
    make && \
    make install

# Build fluffos
RUN git clone https://github.com/fluffos/fluffos.git /usr/src/fluffos
RUN mkdir /usr/src/fluffos/build
WORKDIR /usr/src/fluffos/build
RUN \
    cmake .. -DMARCH_NATIVE=OFF -DSTATIC=ON -DCMAKE_INSTALL_PREFIX=/usr/local/mud && \
    make install

# Copy mudlib to app
RUN \
    mkdir /app && \
    cd /usr/src/fluffos/testsuite && \
    cp -r . /app

# Copy config and setting
ADD config.ini /app

ENTRYPOINT ["/usr/local/mud/bin/driver", "/app/config.ini"]
