# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/input-utils/input-utils-0.0.1_pre20081014.ebuild,v 1.4 2012/06/29 12:34:38 ranger Exp $

EAPI=4
inherit eutils

MY_P="input-${PV/0.0.1_pre/}-101501"

DESCRIPTION="Small collection of linux input layer utils"
HOMEPAGE="http://dl.bytesex.org/cvs-snapshots/"
SRC_URI="http://dl.bytesex.org/cvs-snapshots/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}/input"

src_prepare() {
	cd "${S}"
	# Ported from Debian
	epatch "${FILESDIR}"/input-utils-0.0.1_pre20081014.patch
	# version check stuff
	epatch "${FILESDIR}"/input-utils-0.0.1-protocol-mismatch-fix.patch
}

src_install() {
	make install bindir="${D}"/usr/bin mandir="${D}"/usr/share/man STRIP="" || die "make install failed"
	dodoc lircd.conf
	dodoc README
}
