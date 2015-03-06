# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/snappy/snappy-1.0.5.ebuild,v 1.3 2013/03/26 09:08:11 pinkbyte Exp $

EAPI="5"

inherit eutils

DESCRIPTION="A high-speed compression/decompression library by Google"
HOMEPAGE="https://code.google.com/p/snappy/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86 ~amd64-linux ~x86-linux"
IUSE="static-libs"

DOCS="AUTHORS ChangeLog README NEWS format_description.txt"

src_prepare() {
	default
	# Avoid automagic lzop and gzip by not checking for it
	#sed -i -e '/^CHECK_EXT_COMPRESSION_LIB/d' "${S}/configure.ac" || die
	# Avoid eautoreconf due to the above sed by just removing the expanded lines
	sed -i -e '15126,15385d' "${S}/configure" || die
}

src_configure() {
	econf \
		--without-gflags \
		--disable-gtest \
		$(use_enable static-libs static)
}

src_install() {
	default

	# Remove docs installed by snappy itself
	rm -rf "${ED}/usr/share/doc/snappy" || die

	prune_libtool_files
}