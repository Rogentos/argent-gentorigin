# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libusb/libusb-1.0.9-r2.ebuild,v 1.2 2013/08/08 12:40:30 ssuominen Exp $

EAPI=5
inherit eutils toolchain-funcs multilib-minimal

DESCRIPTION="Userspace access to USB devices"
HOMEPAGE="http://libusb.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="1"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 -amd64-fbsd -x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos"
IUSE="debug doc examples static-libs"

RDEPEND="!dev-libs/libusbx:1
	abi_x86_32? (
		!<=app-emulation/emul-linux-x86-baselibs-20130224-r7
		!app-emulation/emul-linux-x86-baselibs[-abi_x86_32(-)]
	)"
DEPEND="doc? ( app-doc/doxygen )"

multilib_src_configure() {
	ECONF_SOURCE=${S} \
	econf \
		$(use_enable static-libs static) \
		$(use_enable debug debug-log)
}

multilib_src_compile() {
	emake

	if multilib_is_native_abi; then
		use doc && emake -C doc docs
	fi
}

multilib_src_install() {
	emake DESTDIR="${D}" install

	if multilib_is_native_abi; then
		gen_usr_ldscript -a usb-1.0

		use doc && dohtml doc/html/*
	fi
}

multilib_src_install_all() {
	prune_libtool_files

	dodoc AUTHORS NEWS PORTING README THANKS TODO

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins examples/*.c
	fi
}
