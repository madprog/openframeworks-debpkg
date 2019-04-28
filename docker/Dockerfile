from debian:latest

run apt-get update && apt-get install -y --no-install-recommends \
        build-essential:native \
        ca-certificates \
        cmake \
        debhelper \
        dpkg-dev \
        fakeroot \
        pkg-config \
        python3 \
        wget \
    && rm -rf /var/lib/apt-lists/*

run useradd -m -u 1000 builder
user builder
workdir /home/builder
