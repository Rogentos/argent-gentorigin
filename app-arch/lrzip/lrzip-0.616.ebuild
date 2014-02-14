# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/lrzip/lrzip-0.616.ebuild,v 1.4 2014/01/26 13:12:49 hattya Exp $

EAPI=5

inherit eutils

DESCRIPTION="Long Range ZIP or Lzma RZIP optimized for compressing large files"
HOMEPAGE="http://ck.kolivas.org/apps/lrzip/README"
SRC_URI="http://ck.kolivas.org/apps/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~amd64-fbsd ~x86-fbsd"
IUSE=""

RDEPEND="dev-libs/lzo
	 app-arch/bzip2
	 sys-libs/zlib"
DEPEND="${RDEPEND}
	x86? ( dev-lang/nasm )
	virtual/perl-PodParser"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-missing-stdarg_h.patch
}

src_configure() {
	econf --docdir="/usr/share/doc/${P}"
}

src_install() {
	default
	rm "${D}/usr/share/doc/${P}/COPYING"
}
