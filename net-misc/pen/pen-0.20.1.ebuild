# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/pen/pen-0.20.1.ebuild,v 1.1 2013/12/16 05:32:28 patrick Exp $

EAPI="4"

DESCRIPTION="TCP Load Balancing Port Forwarder"
HOMEPAGE="http://siag.nu/pen/"
SRC_URI="http://siag.nu/pub/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="ssl"

DEPEND="ssl? ( dev-libs/openssl )"
RDEPEND="${DEPEND}"

src_configure() {
	econf $(use_with ssl)
}

src_install() {
	emake DESTDIR="${D}" docdir=/usr/share/doc/${PF} install
}
