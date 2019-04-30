.PHONY: all always

#ARCH=i386
ARCH=amd64

#FMODEX_VERSION=4.44.59
FMODEX_VERSION=4.44.64
GLM_VERSION=0.9.8.5
JSON_VERSION=3.6.1
KISS_VERSION=1.3.0
POCO_VERSION=1.9.0-5
SVGTINY_VERSION=
TESS2_VERSION=1.0.1

FMODEX_PKG=libfmodex-dev_${FMODEX_VERSION}_${ARCH}.deb
GLM_PKG=libglm-dev_${GLM_VERSION}_${ARCH}.deb
JSON_PKG=nlohmann-json-dev_${JSON_VERSION}_all.deb
KISS_PKG=libkissfft-dev_${KISS_VERSION}_${ARCH}.deb
POCO_PKG=libpoco-dev_${POCO_VERSION}_${ARCH}.deb
SVGTINY_PKG=libsvgtiny-dev_${SVGTINY_VERSION}_${ARCH}.deb
TESS2_PKG=libtess2-dev_${TESS2_VERSION}_${ARCH}.deb

check_sha=echo "$1 $2" | sha256sum -c --quiet

all: \
     ${FMODEX_PKG} \
     ${GLM_PKG} \
     ${JSON_PKG} \
     ${KISS_PKG} \
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

GLM_URL=https://github.com/g-truc/glm/archive/${GLM_VERSION}.tar.gz
GLM_SHA256=80cf9958f06e5504f8df45ea14fde87411270102930be31c0a16c0da430fc920
GLM_ORIG_PKG=libglm-${GLM_VERSION}.orig.tar.gz
${GLM_PKG}: ${GLM_ORIG_PKG} \
            glm/compat \
            glm/control \
            glm/convert_changelog \
            glm/libglm-dev.install \
            glm/libglm-doc.install \
            glm/rules
	rm -rf $(GLM_ORIG_PKG:%.orig.tar.gz=%)
	tar xzf ${GLM_ORIG_PKG}
	mv "$$(tar tzf ${GLM_ORIG_PKG} | head -n1 | cut -d/ -f1)" "$(GLM_ORIG_PKG:%.orig.tar.gz=%)"
	cd "$(GLM_ORIG_PKG:%.orig.tar.gz=%)" && ln -s ../glm debian
	cd "$(GLM_ORIG_PKG:%.orig.tar.gz=%)" && debian/convert_changelog < readme.md > debian/changelog
	cd "$(GLM_ORIG_PKG:%.orig.tar.gz=%)" && dpkg-buildpackage -b -uc

${GLM_ORIG_PKG}: always
	[ -e "$@" ] && $(call check_sha,${GLM_SHA256},$@) || { \
		rm -f "$@" && \
		wget -O "$@" ${GLM_URL} && \
		$(call check_sha,${GLM_SHA256},$@) || { rm $@ && false; }; }

# JSON

JSON_URL=https://github.com/nlohmann/json/archive/v${JSON_VERSION}.tar.gz
JSON_SHA256=80c45b090e40bf3d7a7f2a6e9f36206d3ff710acfa8d8cc1f8c763bb3075e22e
JSON_ORIG_PKG=nlohmann-json-${JSON_VERSION}.orig.tar.gz
${JSON_PKG}: ${JSON_ORIG_PKG} \
             json/compat \
             json/control \
             json/convert_changelog \
             json/nlohmann-json-dev.install \
             json/rules
	rm -rf $(JSON_ORIG_PKG:%.orig.tar.gz=%)
	tar xzf ${JSON_ORIG_PKG}
	mv "$$(tar tzf ${JSON_ORIG_PKG} | head -n1 | cut -d/ -f1)" "$(JSON_ORIG_PKG:%.orig.tar.gz=%)"
	cd "$(JSON_ORIG_PKG:%.orig.tar.gz=%)" && ln -s ../json debian
	cd "$(JSON_ORIG_PKG:%.orig.tar.gz=%)" && debian/convert_changelog < ChangeLog.md > debian/changelog
	cd "$(JSON_ORIG_PKG:%.orig.tar.gz=%)" && dpkg-buildpackage -b -uc

${JSON_ORIG_PKG}: always
	[ -e "$@" ] && $(call check_sha,${JSON_SHA256},$@) || { \
		rm -f "$@" && \
		wget -O "$@" ${JSON_URL} && \
		$(call check_sha,${JSON_SHA256},$@) || { rm $@ && false; }; }

# KISS

KISS_URL=https://github.com/mborgerding/kissfft/archive/v$(subst .,,${KISS_VERSION}).tar.gz
KISS_SHA256=1782cd90f036765523c72b521ecb1df321883d3cfca65097ba139ff60e696051
KISS_ORIG_PKG=libkissfft-${KISS_VERSION}.orig.tar.gz
${KISS_PKG}: ${KISS_ORIG_PKG} \
             kiss/compat \
             kiss/control \
             kiss/convert_changelog \
             kiss/libkissfft-dev.install \
             kiss/rules
	rm -rf $(KISS_ORIG_PKG:%.orig.tar.gz=%)
	tar xzf ${KISS_ORIG_PKG}
	mv "$$(tar tzf ${KISS_ORIG_PKG} | head -n1 | cut -d/ -f1)" "$(KISS_ORIG_PKG:%.orig.tar.gz=%)"
	cd "$(KISS_ORIG_PKG:%.orig.tar.gz=%)" && ln -s ../kiss debian
	cd "$(KISS_ORIG_PKG:%.orig.tar.gz=%)" && debian/convert_changelog < CHANGELOG > debian/changelog
	cd "$(KISS_ORIG_PKG:%.orig.tar.gz=%)" && dpkg-buildpackage -b -uc

${KISS_ORIG_PKG}: always
	[ -e "$@" ] && $(call check_sha,${KISS_SHA256},$@) || { \
		rm -f "$@" && \
		wget -O "$@" ${KISS_URL} && \
		$(call check_sha,${KISS_SHA256},$@) || { rm $@ && false; }; }

# POCO

POCO_URL=https://salsa.debian.org/debian/poco/-/archive/debian/${POCO_VERSION}/poco-debian-${POCO_VERSION}.tar.gz
POCO_SHA256=8e6f6f4df9d0ad6cdc77e80452f2affb816922341bc446ff31668048292d79f1
POCO_ORIG_PKG=poco-${POCO_VERSION}.orig.tar.gz
${POCO_PKG}: ${POCO_ORIG_PKG}
	rm -rf $(POCO_ORIG_PKG:%.orig.tar.gz=%)
	tar xzf ${POCO_ORIG_PKG}
	mv "$$(tar tzf ${POCO_ORIG_PKG} | head -n1 | cut -d/ -f1)" "$(POCO_ORIG_PKG:%.orig.tar.gz=%)"
	cd "$(POCO_ORIG_PKG:%.orig.tar.gz=%)" && patch -p1 < ../poco/debhelper_11_to_9.patch
	cd "$(POCO_ORIG_PKG:%.orig.tar.gz=%)" && dpkg-buildpackage -b -uc

${POCO_ORIG_PKG}: always
	[ -e "$@" ] && $(call check_sha,${POCO_SHA256},$@) || { \
		rm -f "$@" && \
		wget -O "$@" ${POCO_URL} && \
		$(call check_sha,${POCO_SHA256},$@) || { rm $@ && false; }; }

# SVGTINY

${SVGTINY_PKG}:

# TESS2

${TESS2_PKG}:

# UTF8

${UTF8_PKG}:

