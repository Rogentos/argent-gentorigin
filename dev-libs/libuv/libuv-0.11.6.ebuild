# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libuv/libuv-0.11.6.ebuild,v 1.1 2013/08/01 16:06:11 hasufell Exp $

EAPI=5

inherit eutils autotools

DESCRIPTION="A new platform layer for Node"
HOMEPAGE="https://github.com/joyent/libuv"
SRC_URI="https://github.com/joyent/libuv/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD BSD-2 ISC MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="static-libs"

src_prepare() {
	sed -i \
		-e 's/-Werror//' \
		configure.ac || die

	eautoreconf
}

src_configure() {
	econf \
		$(use_enable static-libs static)
}

src_install() {
	default
	prune_libtool_files
}
