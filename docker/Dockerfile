from debian:latest

run apt-get update && apt-get install -y --no-install-recommends \
        build-essential:native \
        ca-certificates \
        cmake \
        debhelper \
        default-libmysqlclient-dev \
        doxygen \
        dpkg-dev \
        fakeroot \
        ghostscript \
        graphviz \
        libexpat1-dev \
        libpcre3-dev \
        libsqlite3-dev \
        libssl-dev \
        pkg-config \
        python3 \
        re2c \
        texlive-binaries \
        texlive-latex-base \
        unixodbc-dev \
        wget \
        zlib1g-dev \
    && rm -rf /var/lib/apt-lists/*

run useradd -m -u 1000 builder
user builder
workdir /home/builder
