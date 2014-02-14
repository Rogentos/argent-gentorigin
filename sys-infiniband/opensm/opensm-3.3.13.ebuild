# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-infiniband/opensm/opensm-3.3.13.ebuild,v 1.1 2012/04/18 16:45:30 alexxy Exp $

EAPI="4"

OFED_VER="1.5.4.1"
OFED_SUFFIX="1"

inherit openib

DESCRIPTION="OpenSM - InfiniBand Subnet Manager and Administration for OpenIB"
KEYWORDS="~amd64 ~x86 ~amd64-linux"
IUSE=""

DEPEND="
	sys-infiniband/libibmad:${SLOT}
	sys-infiniband/libibumad:${SLOT}"
RDEPEND="$DEPEND
	 net-misc/iputils"
block_other_ofed_versions

src_configure() {
	econf \
		--enable-perf-mgr \
		--enable-default-event-plugin \
		--with-osmv="openib"
}

src_install() {
	default
	newconfd "${S}/scripts/opensm.sysconfig" opensm
	newinitd "${FILESDIR}/opensm.init.d" opensm
	insinto /etc/logrotate.d
	newins "${S}/scripts/opensm.logrotate" opensm
	# we dont nee this int script
	rm "${ED}/etc/init.d/opensmd" || die "Dropping of upstream initscript failed"
}

pkg_postinst() {
	einfo "To automatically configure the infiniband subnet manager on boot,"
	einfo "edit /etc/opensm.conf and add opensm to your start-up scripts:"
	einfo "\`rc-update add opensm default\`"
}
