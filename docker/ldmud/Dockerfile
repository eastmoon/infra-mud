FROM ubuntu:18.04

# Install common tools
RUN \
    apt-get update -y && \
    apt-get install -y  --no-install-recommends \
        apt-transport-https \
        software-properties-common \
        ca-certificates \
        libcurl4 \
        wget \
        git

# Install complier tools
RUN \
    apt-get update -y && \
    apt-get install -y  --no-install-recommends \
        build-essential \
        gcc \
        g++ \
        python-dev \
        make \
        cmake

# Download ldmud
RUN \
    git clone https://github.com/ldmud/ldmud.git /usr/src/ldmud

# LDMud support library
RUN \
    apt-get update -y && \
    apt-get install -y \
        bison \
        libpcre++-dev \
        libgcrypt20-dev

# Copy mudlib to app
RUN \
    mkdir /app && \
    cd /usr/src/ldmud/mud/lp-245 && \
    cp -r . /app

# Compile ldmud
Run \
    cd /usr/src/ldmud/src && \
    ./autogen.sh && \
    ./configure --libdir=/app && \
    make install-all

# Container setting
WORKDIR /app
EXPOSE 5000/tcp

# Entrypoint setting
ENTRYPOINT ["/usr/local/mud/bin/ldmud", "5000"]
