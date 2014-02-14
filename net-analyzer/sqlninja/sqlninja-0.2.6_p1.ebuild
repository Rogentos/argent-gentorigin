# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/sqlninja/sqlninja-0.2.6_p1.ebuild,v 1.1 2012/10/06 13:13:46 pinkbyte Exp $

EAPI=4

inherit versionator

MY_PV="$(replace_version_separator 3 '-')"
MY_PV="${MY_PV/p/r}"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="A SQL Server injection & takeover tool"
HOMEPAGE="http://sqlninja.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND=""
RDEPEND="dev-lang/perl
	dev-perl/NetPacket
	dev-perl/Net-Pcap
	dev-perl/Net-DNS
	dev-perl/Net-RawIP
	dev-perl/IO-Socket-SSL
	dev-perl/List-MoreUtils"

S="${WORKDIR}/${MY_P}"

src_install () {
	dodoc sqlninja-howto.html ChangeLog README
	if use doc; then
		dodoc -r sources
		docompress -x /usr/share/doc/"${P}"/sources
	fi
	insinto /etc/"${PN}"
	doins sqlninja.conf.example

	rm -r sources sqlninja-howto.html ChangeLog README LICENSE || die 'removing docs failed'
	rm -r apps || die 'removing bundles apps failed'
	rm sqlninja.conf.example || die 'removing config failed'

	dodir /usr/lib/"${PN}"
	insinto /usr/lib/"${PN}"
	exeinto /usr/lib/"${PN}"
	doins -r *
	doexe sqlninja
	dosbin "${FILESDIR}"/"${PN}"
	dosym /usr/lib/"${PN}"/makescr.pl /usr/sbin/makescr.pl
}
