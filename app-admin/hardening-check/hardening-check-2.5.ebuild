# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/hardening-check/hardening-check-2.5.ebuild,v 1.1 2013/12/29 17:49:34 ago Exp $

EAPI="5"

MY_PN="hardening-wrapper"

DESCRIPTION="Report the hardening characterists of a set of binaries"
HOMEPAGE="https://wiki.debian.org/Hardening"
SRC_URI="mirror://debian/pool/main/h/${MY_PN}/${MY_PN}_${PV}.tar.gz"

KEYWORDS="~amd64 ~x86"
IUSE=""
LICENSE="GPL-2+"
SLOT="0"

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${MY_PN}"

src_compile() { :; }

src_install() {
	newbin ${PN}.sh ${PN}
}
