from debian:latest

run apt-get update && apt-get install -y --no-install-recommends \
        build-essential:native \
        ca-certificates \
        check \
        cmake \
        debhelper \
        default-libmysqlclient-dev \
        doxygen \
        dpkg-dev \
        fakeroot \
        ghostscript \
        gperf \
        graphviz \
        libexpat1-dev \
        libjson-c-dev \
        libpcre3-dev \
        libsqlite3-dev \
        libssl-dev \
        libswitch-perl \
        libxml-perl \
        libxml-xpath-perl \
        pkg-config \
        python3 \
        re2c \
        sudo \
        texlive-binaries \
        texlive-latex-base \
        unixodbc-dev \
        wget \
        zlib1g-dev \
    && rm -rf /var/lib/apt-lists/*

run echo "builder ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/builder
run useradd -m -u 1000 builder
user builder
workdir /home/builder
