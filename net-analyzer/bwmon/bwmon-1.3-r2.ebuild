# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/bwmon/bwmon-1.3-r2.ebuild,v 1.6 2012/11/21 11:16:40 ago Exp $

EAPI="4"

inherit eutils toolchain-funcs

DESCRIPTION="Simple ncurses bandwidth monitor"
HOMEPAGE="http://bwmon.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

DEPEND="sys-libs/ncurses"
RDEPEND="${DEPEND}"

SLOT="0"
LICENSE="GPL-2 public-domain"
KEYWORDS="amd64 hppa ppc sparc x86"
IUSE=""

src_prepare() {
	epatch "${FILESDIR}"/${P}-build.patch
	# Fix a typo in help wrt bug #263326
	epatch "${FILESDIR}"/${P}-typo-fix.patch
	# Fix an overflow wrt bug #441420
	epatch "${FILESDIR}"/${P}-overflow.patch
}

src_compile() {
	emake -Csrc CC="$(tc-getCC)"
}

src_install () {
	dobin ${PN}
	dodoc README
}
