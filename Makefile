.PHONY: all always

#ARCH=i386
ARCH=amd64

#FMODEX_VERSION=4.44.59
FMODEX_VERSION=4.44.64
GLM_VERSION=
JSON_VERSION=
KISS_VERSION=
LIBXML2_VERSION=
POCO_VERSION=
SVGTINY_VERSION=
TESS2_VERSION=1.0.1

FMODEX_PKG=libfmodex-dev_${FMODEX_VERSION}_${ARCH}.deb
GLM_PKG=libglm-dev_${GLM_VERSION}_${ARCH}.deb
JSON_PKG=libjson-dev_${JSON_VERSION}_${ARCH}.deb
KISS_PKG=libkiss2-dev_${KISS_VERSION}_${ARCH}.deb
LIBXML2_PKG=libxml2-dev_${LIBXML2_VERSION}_${ARCH}.deb
POCO_PKG=libpoco-dev_${POCO_VERSION}_${ARCH}.deb
SVGTINY_PKG=libsvgtiny-dev_${SVGTINY_VERSION}_${ARCH}.deb
TESS2_PKG=libtess2-dev_${TESS2_VERSION}_${ARCH}.deb

check_sha=echo "$1 $2" | sha256sum -c --quiet

all: \
     ${FMODEX_PKG} \
     ${GLM_PKG} \
     ${JSON_PKG} \
     ${KISS_PKG} \
     ${LIBXML2_PKG} \
     ${POCO_PKG} \
     ${SVGTINY_PKG} \
     ${TESS2_PKG} \
     ${UTF8_PKG}

# FMODEX

FMODEX_URL=https://zdoom.org/files/fmod/fmodapi44464linux.tar.gz
FMODEX_SHA256=21a24f1394ae6981a47be0281f69ce41201801e59fb88084c49c5fd5459af010
FMODEX_ORIG_PKG=libfmodex-${FMODEX_VERSION}.orig.tar.gz
${FMODEX_PKG}: ${FMODEX_ORIG_PKG} \
               fmodex/compat \
               fmodex/control \
               fmodex/convert_changelog \
               fmodex/libfmodex-dev.install \
               fmodex/libfmodex-doc.install \
               fmodex/libfmodex.install \
               fmodex/rules
	rm -rf $(FMODEX_ORIG_PKG:%.orig.tar.gz=%)
	tar xzf ${FMODEX_ORIG_PKG}
	mv "$$(tar tzf ${FMODEX_ORIG_PKG} | head -n1 | cut -d/ -f1)" "$(FMODEX_ORIG_PKG:%.orig.tar.gz=%)"
	cd "$(FMODEX_ORIG_PKG:%.orig.tar.gz=%)" && ln -s ../fmodex debian
	cd "$(FMODEX_ORIG_PKG:%.orig.tar.gz=%)" && debian/convert_changelog < documentation/revision.txt > debian/changelog
	cd "$(FMODEX_ORIG_PKG:%.orig.tar.gz=%)" && dpkg-buildpackage -b -uc

${FMODEX_ORIG_PKG}: always
	[ -e "$@" ] && $(call check_sha,${FMODEX_SHA256},$@) || { \
		rm -f "$@" && \
		wget -O "$@" ${FMODEX_URL} && \
		$(call check_sha,${FMODEX_SHA256},$@) || { rm $@ && false; }; }

# GLM

${GLM_PKG}:

# JSON

${JSON_PKG}:

# KISS

${KISS_PKG}:

# LIBXML2

${LIBXML2_PKG}:

# POCO

${POCO_PKG}:

# SVGTINY

${SVGTINY_PKG}:

# TESS2

${TESS2_PKG}:

# UTF8

${UTF8_PKG}:

