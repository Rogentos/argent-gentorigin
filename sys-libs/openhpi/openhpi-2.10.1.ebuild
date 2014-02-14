# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/openhpi/openhpi-2.10.1.ebuild,v 1.1 2008/11/01 08:19:05 robbat2 Exp $

inherit eutils

DESCRIPTION="OpenHPI provides an open source implementation of the Service Availability Forum (SAF) Hardware Platform Interface (HPI)"
HOMEPAGE="http://www.openhpi.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="snmp"

COMMONDEPEND=">=dev-libs/glib-2.2
	sys-fs/e2fsprogs
	sys-fs/sysfsutils
	>=sys-libs/openipmi-1.4.20
	snmp? ( >=net-analyzer/net-snmp-5.07 )"
RDEPEND="${COMMONDEPEND}"
DEPEND="${COMMONDEPEND}
	>=sys-devel/autoconf-2.57
	>=sys-devel/automake-1.8
	>=sys-devel/gcc-3.2.0
	virtual/os-headers"

src_compile() {
	econf --with-varpath=/var/lib/openhpi \
		--enable-clients \
		--enable-cpp_wrappers \
		--enable-daemon \
		--enable-ipmi \
		--enable-ipmidirect \
		--enable-sysfs \
		--enable-thread \
		--enable-watchdog \
		--enable-simulator \
		--disable-testcover \
		$(use_enable snmp snmp_bc) \
		|| die "econf failed"

	emake || die "emake failed"
}

src_install() {
	# Stage main files.
	emake DESTDIR="${D}" install || die "emake install failed"

	# Stage conf.d-file and init.d-script.
	newinitd "${FILESDIR}"/openhpi-initd openhpid
	newconfd "${FILESDIR}"/openhpi-confd openhpid

	# Stage documentation.
	dodoc README

	# Make sure the data dir exists or openhpid will fail silently.
	keepdir /var/lib/openhpi/
}
