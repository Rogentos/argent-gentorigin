# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/tbb/tbb-4.3.20150611.ebuild,v 1.1 2015/06/15 17:08:07 jlec Exp $

EAPI=5

inherit eutils flag-o-matic multilib-minimal toolchain-funcs versionator

PV1="$(get_version_component_range 1)"
PV2="$(get_version_component_range 2)"
PV3="$(get_version_component_range 3)"
MYP="${PN}${PV1}${PV2}_${PV3}oss"

DESCRIPTION="High level abstract threading library"
HOMEPAGE="http://www.threadingbuildingblocks.org/"
SRC_URI="http://threadingbuildingblocks.org/sites/default/files/software_releases/source/${MYP}_src.tgz"
LICENSE="GPL-2-with-exceptions"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86 ~amd64-fbsd ~amd64-linux ~x86-linux"
IUSE="debug doc examples"

DEPEND=""
RDEPEND="${DEPEND}"
S="${WORKDIR}/${MYP}"

src_prepare() {
	epatch \
		"${FILESDIR}"/${PN}-4.0.297-underlinking.patch \
		"${FILESDIR}"/${P}-build.patch

	find include -name \*.html -delete || die

	# Give it a soname on FreeBSD
	echo 'LIB_LINK_FLAGS += -Wl,-soname=$(BUILDING_LIBRARY)' >>	build/FreeBSD.gcc.inc
	# Set proper versionning on FreeBSD
	sed -i -e '/.DLL =/s/$/.1/' build/FreeBSD.inc || die

	use debug || sed -i -e '/_debug/d' Makefile
}

multilib_src_configure() {
	# pc files are for debian and fedora compatibility
	# some deps use them
	cat <<-EOF > ${PN}.pc.template
		prefix=${EPREFIX}/usr
		libdir=\${prefix}/$(get_libdir)
		includedir=\${prefix}/include
		Name: ${PN}
		Description: ${DESCRIPTION}
		Version: ${PV}
		URL: ${HOMEPAGE}
		Cflags: -I\${includedir}
	EOF
	cp ${PN}.pc.template ${PN}.pc || die
	cat <<-EOF >> ${PN}.pc
		Libs: -L\${libdir} -ltbb
		Libs.private: -lm -lrt
	EOF
	cp ${PN}.pc.template ${PN}malloc.pc || die
	cat <<-EOF >> ${PN}malloc.pc
		Libs: -L\${libdir} -ltbbmalloc
		Libs.private: -lm -lrt
	EOF
	cp ${PN}.pc.template ${PN}malloc_proxy.pc || die
	cat <<-EOF >> ${PN}malloc_proxy.pc
		Libs: -L\${libdir} -ltbbmalloc_proxy
		Libs.private: -lrt
		Requires: tbbmalloc
	EOF
}

local_src_compile() {
	cd "${S}"

	local comp arch

	case ${MULTILIB_ABI_FLAG} in
		abi_x86_64) arch=x86_64 ;;
		abi_x86_32) arch=ia32 ;;
	esac

	case "$(tc-getCXX)" in
		*g++*) comp="gcc" ;;
		*ic*c) comp="icc" ;;
		*clang*) comp="clang" ;;
		*) die "compiler $(tc-getCXX) not supported by build system" ;;
	esac

	CXX="$(tc-getCXX)" \
	CC="$(tc-getCC)" \
	AS="$(tc-getAS)" \
	arch=${arch} \
	CPLUS_FLAGS="${CXXFLAGS}" \
	emake compiler=${comp} work_dir="${BUILD_DIR}" tbb_root="${S}" $@
}

multilib_src_compile() {
	local_src_compile tbb tbbmalloc
}

multilib_src_test() {
	CXXFLAGS="${CXXFLAGS} -fabi-version=4" \
	local_src_compile -j1 test
}

multilib_src_install() {
	cd "${BUILD_DIR}_release" || die
	local l
	for l in $(find . -name lib\*.so.\*); do
		dolib.so ${l}
		local bl=$(basename ${l})
		dosym ${bl} /usr/$(get_libdir)/${bl%.*}
	done

	cd "${BUILD_DIR}" || die
	insinto /usr/$(get_libdir)/pkgconfig
	doins *.pc
}

multilib_src_install_all() {
	doheader -r include/*

	dodoc README CHANGES doc/Release_Notes.txt
	use doc && dohtml -r doc/html/*

	if use examples ; then
		insinto /usr/share/doc/${PF}/examples/build
		doins build/*.inc
		insinto /usr/share/doc/${PF}/examples
		doins -r examples
	fi
}