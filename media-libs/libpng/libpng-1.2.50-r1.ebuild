# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libpng/libpng-1.2.50-r1.ebuild,v 1.4 2014/01/04 21:13:38 ago Exp $

EAPI=5

# this ebuild is only for the libpng12.so.0 SONAME for ABI compat

inherit libtool multilib-minimal

DESCRIPTION="Portable Network Graphics library"
HOMEPAGE="http://www.libpng.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.xz"

LICENSE="libpng"
SLOT="1.2"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc64 ~s390 ~sh ~sparc x86 ~sparc-fbsd ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND=">=sys-libs/zlib-1.2.8-r1:=[${MULTILIB_USEDEP}]
	!=media-libs/libpng-1.2*:0
	abi_x86_32? ( !<=app-emulation/emul-linux-x86-baselibs-20130224-r3
		!app-emulation/emul-linux-x86-baselibs[-abi_x86_32(-)] )"
DEPEND="${RDEPEND}
	app-arch/xz-utils"

src_prepare() {
	elibtoolize
}

multilib_src_configure() {
	ECONF_SOURCE=${S} econf --disable-static
}

multilib_src_compile() {
	emake libpng12.la
}

multilib_src_install() {
	newlib.so .libs/libpng12.so.0.* libpng12.so.0
}
