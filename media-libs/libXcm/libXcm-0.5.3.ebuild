# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libXcm/libXcm-0.5.3.ebuild,v 1.1 2014/07/30 22:29:44 xmw Exp $

EAPI=5

inherit autotools-multilib

DESCRIPTION="reference implementation of the net-color spec"
HOMEPAGE="http://www.oyranos.org/libxcm/"
SRC_URI="mirror://sourceforge/oyranos/${PN}/${PN}-0.4.x/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="X doc static-libs"

RDEPEND="X? ( >=x11-libs/libXmu-1.1.1-r1[${MULTILIB_USEDEP}]
		>=x11-libs/libXfixes-5.0.1[${MULTILIB_USEDEP}]
		>=x11-libs/libX11-1.6.2[${MULTILIB_USEDEP}]
		>=x11-proto/xproto-7.0.24[${MULTILIB_USEDEP}] )"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"

src_configure() {
	local myeconfargs=(
		--disable-silent-rules
		$(use_with X x11)
		$(use_enable static-libs static)
	)
	autotools-multilib_src_configure
}

src_compile() {
	autotools-multilib_src_compile
	use doc && doxygen
}

src_install() {
	autotools-multilib_src_install
	use doc && dohtml doc/html/*
}