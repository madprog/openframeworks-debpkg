# Debian packages for Openframeworks and its dependencies

This project aims to build Debian packages (`.deb`) for Openframeworks and its dependencies.

To build them on any platform, install `docker` and `docker-compose` and execute:

```
$ ./docker-make
```

On Debian, install `build-essential:native`, `debhelper`, `dpkg-dev` and `fakeroot`, and execute:

```
$ make
```
