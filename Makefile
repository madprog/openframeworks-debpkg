.PHONY: all always

#ARCH=i386
ARCH=amd64

#FMODEX_VERSION=4.44.59
FMODEX_VERSION=4.44.64
GLM_VERSION=0.9.8.5
JSON_VERSION=3.6.1
KISS_VERSION=1.3.0
LIBDOM_VERSION=0.3.3
LIBHUBBUB_VERSION=0.3.5
LIBPARSERUTILS_VERSION=0.2.4
LIBWAPCAPLET_VERSION=0.4.1
NETSURF_BUILDSYSTEM_VERSION=1.7
POCO_VERSION=1.9.0-5
SVGTINY_VERSION=0.1.7
TESS2_VERSION=1.0.1

FMODEX_PKG=libfmodex-dev_${FMODEX_VERSION}_${ARCH}.deb
GLM_PKG=libglm-dev_${GLM_VERSION}_${ARCH}.deb
JSON_PKG=nlohmann-json-dev_${JSON_VERSION}_all.deb
KISS_PKG=libkissfft-dev_${KISS_VERSION}_${ARCH}.deb
LIBDOM_PKG=libdom-dev_${LIBDOM_VERSION}_${ARCH}.deb
LIBHUBBUB_PKG=libhubbub-dev_${LIBHUBBUB_VERSION}_${ARCH}.deb
LIBPARSERUTILS_PKG=libparserutils-dev_${LIBPARSERUTILS_VERSION}_${ARCH}.deb
LIBWAPCAPLET_PKG=libwapcaplet-dev_${LIBWAPCAPLET_VERSION}_${ARCH}.deb
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

# NETSURF BUILD SYSTEM (for SVGTINY)

NETSURF_BS_URL=http://git.netsurf-browser.org/buildsystem.git/snapshot/buildsystem-release/${NETSURF_BUILDSYSTEM_VERSION}.tar.gz
NETSURF_BS_SHA256=9535fb409df4d3a091aa91267a009aba50f160074576ac82103d22f7c8b23f90
NETSURF_BS_ORIG_PKG=netsurf-buildsystem-${NETSURF_BUILDSYSTEM_VERSION}.orig.tar.gz

$(NETSURF_BS_ORIG_PKG:%.orig.tar.gz=%): ${NETSURF_BS_ORIG_PKG}
	rm -rf $(NETSURF_BS_ORIG_PKG:%.orig.tar.gz=%)
	tar xzf ${NETSURF_BS_ORIG_PKG}
	mv "$$(tar tzf ${NETSURF_BS_ORIG_PKG} | head -n1 | cut -d/ -f1,2)" "$(NETSURF_BS_ORIG_PKG:%.orig.tar.gz=%)"
	rmdir "$$(tar tzf ${NETSURF_BS_ORIG_PKG} | head -n1 | cut -d/ -f1)"

${NETSURF_BS_ORIG_PKG}: always
	[ -e "$@" ] && $(call check_sha,${NETSURF_BS_SHA256},$@) || { \
		rm -f "$@" && \
		wget -O "$@" ${NETSURF_BS_URL} && \
		$(call check_sha,${NETSURF_BS_SHA256},$@) || { rm $@ && false; }; }

# LIBWAPCAPLET (for SVGTINY)

LIBWAPCAPLET_URL=http://git.netsurf-browser.org/libwapcaplet.git/snapshot/libwapcaplet-release/${LIBWAPCAPLET_VERSION}.tar.gz
LIBWAPCAPLET_SHA256=cccaac629c4db9c731ede6f727603ba2a79055a132c0a061af75d30094ed89ad
LIBWAPCAPLET_ORIG_PKG=libwapcaplet-${LIBWAPCAPLET_VERSION}.orig.tar.gz

${LIBWAPCAPLET_PKG}: ${LIBWAPCAPLET_ORIG_PKG} \
                     $(NETSURF_BS_ORIG_PKG:%.orig.tar.gz=%) \
                     wapcaplet/changelog \
                     wapcaplet/compat \
                     wapcaplet/control \
                     wapcaplet/libwapcaplet-dev.install \
                     wapcaplet/rules
	rm -rf $(LIBWAPCAPLET_ORIG_PKG:%.orig.tar.gz=%)
	tar xzf ${LIBWAPCAPLET_ORIG_PKG}
	mv "$$(tar tzf ${LIBWAPCAPLET_ORIG_PKG} | head -n1 | cut -d/ -f1,2)" "$(LIBWAPCAPLET_ORIG_PKG:%.orig.tar.gz=%)"
	rmdir "$$(tar tzf ${LIBWAPCAPLET_ORIG_PKG} | head -n1 | cut -d/ -f1)"
	cd "$(LIBWAPCAPLET_ORIG_PKG:%.orig.tar.gz=%)" && ln -s ../wapcaplet debian
	cd "$(LIBWAPCAPLET_ORIG_PKG:%.orig.tar.gz=%)" && dpkg-buildpackage -b -uc

${LIBWAPCAPLET_ORIG_PKG}: always
	[ -e "$@" ] && $(call check_sha,${LIBWAPCAPLET_SHA256},$@) || { \
		rm -f "$@" && \
		wget -O "$@" ${LIBWAPCAPLET_URL} && \
		$(call check_sha,${LIBWAPCAPLET_SHA256},$@) || { rm $@ && false; }; }

/usr/lib/pkgconfig/libwapcaplet.pc: ${LIBWAPCAPLET_PKG}
	sudo dpkg -i ${LIBWAPCAPLET_PKG}

# LIBDOM (for SVGTINY)

LIBDOM_URL=http://git.netsurf-browser.org/libdom.git/snapshot/libdom-release/${LIBDOM_VERSION}.tar.gz
LIBDOM_SHA256=01a1b55624fe5c0b78af16f7f09bca8042e2a2ba8df80468674cecf17db026d1
LIBDOM_ORIG_PKG=libdom-${LIBDOM_VERSION}.orig.tar.gz

${LIBDOM_PKG}: ${LIBDOM_ORIG_PKG} \
               $(NETSURF_BS_ORIG_PKG:%.orig.tar.gz=%) \
               /usr/lib/pkgconfig/libhubbub.pc \
               /usr/lib/pkgconfig/libparserutils.pc \
               dom/changelog \
               dom/compat \
               dom/control \
               dom/libdom-dev.install \
               dom/rules
	rm -rf $(LIBDOM_ORIG_PKG:%.orig.tar.gz=%)
	tar xzf ${LIBDOM_ORIG_PKG}
	mv "$$(tar tzf ${LIBDOM_ORIG_PKG} | head -n1 | cut -d/ -f1,2)" "$(LIBDOM_ORIG_PKG:%.orig.tar.gz=%)"
	rmdir "$$(tar tzf ${LIBDOM_ORIG_PKG} | head -n1 | cut -d/ -f1)"
	cd "$(LIBDOM_ORIG_PKG:%.orig.tar.gz=%)" && ln -s ../dom debian
	cd "$(LIBDOM_ORIG_PKG:%.orig.tar.gz=%)" && dpkg-buildpackage -b -uc

${LIBDOM_ORIG_PKG}: always
	[ -e "$@" ] && $(call check_sha,${LIBDOM_SHA256},$@) || { \
		rm -f "$@" && \
		wget -O "$@" ${LIBDOM_URL} && \
		$(call check_sha,${LIBDOM_SHA256},$@) || { rm $@ && false; }; }

/usr/lib/pkgconfig/libdom.pc: ${LIBDOM_PKG}
	sudo dpkg -i ${LIBDOM_PKG}

# LIBHUBBUB (for LIBDOM)

LIBHUBBUB_URL=http://git.netsurf-browser.org/libhubbub.git/snapshot/libhubbub-release/${LIBHUBBUB_VERSION}.tar.gz
LIBHUBBUB_SHA256=c0a08359a9ae17c04b5c936b70c9b19bf2b1a6b8d685f476348b4694c91798a1
LIBHUBBUB_ORIG_PKG=libhubbub-${LIBHUBBUB_VERSION}.orig.tar.gz

${LIBHUBBUB_PKG}: ${LIBHUBBUB_ORIG_PKG} \
               $(NETSURF_BS_ORIG_PKG:%.orig.tar.gz=%) \
               /usr/lib/pkgconfig/libparserutils.pc \
               hubbub/changelog \
               hubbub/compat \
               hubbub/control \
               hubbub/libhubbub-dev.install \
               hubbub/rules
	rm -rf $(LIBHUBBUB_ORIG_PKG:%.orig.tar.gz=%)
	tar xzf ${LIBHUBBUB_ORIG_PKG}
	mv "$$(tar tzf ${LIBHUBBUB_ORIG_PKG} | head -n1 | cut -d/ -f1,2)" "$(LIBHUBBUB_ORIG_PKG:%.orig.tar.gz=%)"
	rmdir "$$(tar tzf ${LIBHUBBUB_ORIG_PKG} | head -n1 | cut -d/ -f1)"
	cd "$(LIBHUBBUB_ORIG_PKG:%.orig.tar.gz=%)" && ln -s ../hubbub debian
	cd "$(LIBHUBBUB_ORIG_PKG:%.orig.tar.gz=%)" && dpkg-buildpackage -b -uc

${LIBHUBBUB_ORIG_PKG}: always
	[ -e "$@" ] && $(call check_sha,${LIBHUBBUB_SHA256},$@) || { \
		rm -f "$@" && \
		wget -O "$@" ${LIBHUBBUB_URL} && \
		$(call check_sha,${LIBHUBBUB_SHA256},$@) || { rm $@ && false; }; }

/usr/lib/pkgconfig/libhubbub.pc: ${LIBHUBBUB_PKG}
	sudo dpkg -i ${LIBHUBBUB_PKG}

# LIBPARSERUTILS (for LIBDOM)

LIBPARSERUTILS_URL=http://git.netsurf-browser.org/libparserutils.git/snapshot/libparserutils-release/${LIBPARSERUTILS_VERSION}.tar.gz
LIBPARSERUTILS_SHA256=c316c7bf4b50ce1003f35060807467e4a9d24a3be108c891f522a8ad320f032c
LIBPARSERUTILS_ORIG_PKG=libparserutils-${LIBPARSERUTILS_VERSION}.orig.tar.gz

${LIBPARSERUTILS_PKG}: ${LIBPARSERUTILS_ORIG_PKG} \
               $(NETSURF_BS_ORIG_PKG:%.orig.tar.gz=%) \
               parserutils/changelog \
               parserutils/compat \
               parserutils/control \
               parserutils/libparserutils-dev.install \
               parserutils/rules
	rm -rf $(LIBPARSERUTILS_ORIG_PKG:%.orig.tar.gz=%)
	tar xzf ${LIBPARSERUTILS_ORIG_PKG}
	mv "$$(tar tzf ${LIBPARSERUTILS_ORIG_PKG} | head -n1 | cut -d/ -f1,2)" "$(LIBPARSERUTILS_ORIG_PKG:%.orig.tar.gz=%)"
	rmdir "$$(tar tzf ${LIBPARSERUTILS_ORIG_PKG} | head -n1 | cut -d/ -f1)"
	cd "$(LIBPARSERUTILS_ORIG_PKG:%.orig.tar.gz=%)" && ln -s ../parserutils debian
	cd "$(LIBPARSERUTILS_ORIG_PKG:%.orig.tar.gz=%)" && dpkg-buildpackage -b -uc

${LIBPARSERUTILS_ORIG_PKG}: always
	[ -e "$@" ] && $(call check_sha,${LIBPARSERUTILS_SHA256},$@) || { \
		rm -f "$@" && \
		wget -O "$@" ${LIBPARSERUTILS_URL} && \
		$(call check_sha,${LIBPARSERUTILS_SHA256},$@) || { rm $@ && false; }; }

/usr/lib/pkgconfig/libparserutils.pc: ${LIBPARSERUTILS_PKG}
	sudo dpkg -i ${LIBPARSERUTILS_PKG}

# SVGTINY

SVGTINY_URL=http://git.netsurf-browser.org/libsvgtiny.git/snapshot/libsvgtiny-release/${SVGTINY_VERSION}.tar.gz
SVGTINY_SHA256=218f3aed74a16b2d2770dd9a4a8cbd5ae0722fdc6a0a27d185de9962b7b05058
SVGTINY_ORIG_PKG=libsvgtiny-${SVGTINY_VERSION}.orig.tar.gz
${SVGTINY_PKG}: ${SVGTINY_ORIG_PKG} \
                $(NETSURF_BS_ORIG_PKG:%.orig.tar.gz=%) \
                /usr/lib/pkgconfig/libwapcaplet.pc \
                /usr/lib/pkgconfig/libdom.pc \
                svgtiny/changelog \
                svgtiny/compat \
                svgtiny/control \
                svgtiny/rules
	rm -rf $(SVGTINY_ORIG_PKG:%.orig.tar.gz=%)
	tar xzf ${SVGTINY_ORIG_PKG}
	mv "$$(tar tzf ${SVGTINY_ORIG_PKG} | head -n1 | cut -d/ -f1,2)" "$(SVGTINY_ORIG_PKG:%.orig.tar.gz=%)"
	rmdir "$$(tar tzf ${SVGTINY_ORIG_PKG} | head -n1 | cut -d/ -f1)"
	cd "$(SVGTINY_ORIG_PKG:%.orig.tar.gz=%)" && ln -s ../svgtiny debian
	cd "$(SVGTINY_ORIG_PKG:%.orig.tar.gz=%)" && dpkg-buildpackage -b -uc

${SVGTINY_ORIG_PKG}: always
	[ -e "$@" ] && $(call check_sha,${SVGTINY_SHA256},$@) || { \
		rm -f "$@" && \
		wget -O "$@" ${SVGTINY_URL} && \
		$(call check_sha,${SVGTINY_SHA256},$@) || { rm $@ && false; }; }

# TESS2

${TESS2_PKG}:

# UTF8

${UTF8_PKG}:

