# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-block/nbd/nbd-2.9.24.ebuild,v 1.2 2012/05/03 04:46:47 jdhore Exp $

EAPI="4"

DESCRIPTION="Userland client/server for kernel network block device"
HOMEPAGE="http://nbd.sourceforge.net/"
SRC_URI="mirror://sourceforge/nbd/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

RDEPEND=">=dev-libs/glib-2.0"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_configure() {
	econf \
		--enable-lfs \
		--enable-syslog
}

src_compile() {
	emake
	emake -C gznbd
}

src_install() {
	default
	dobin gznbd/gznbd
}
