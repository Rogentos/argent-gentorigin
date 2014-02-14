# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libsidplayfp/libsidplayfp-1.1.0.ebuild,v 1.4 2014/01/28 14:06:31 ago Exp $

EAPI=5
inherit eutils

DESCRIPTION="A library for the sidplay2 fork with resid-fp"
HOMEPAGE="http://sourceforge.net/projects/sidplay-residfp/"
SRC_URI="mirror://sourceforge/sidplay-residfp/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~hppa x86"
IUSE="mmx static-libs"

DOCS=( AUTHORS NEWS README TODO )

src_prepare() {
	# fix automagic. warning: modifying .ac triggers maintainer mode.
	sed -i -e 's:doxygen:dIsAbLe&:' configure || die
}

src_configure() {
	econf \
		$(use_enable static-libs static) \
		$(use_enable mmx)
}

src_install() {
	default
	prune_libtool_files
}
