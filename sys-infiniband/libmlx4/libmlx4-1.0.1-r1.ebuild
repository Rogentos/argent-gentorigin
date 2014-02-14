# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-infiniband/libmlx4/libmlx4-1.0.1-r1.ebuild,v 1.1 2012/04/18 16:42:56 alexxy Exp $

EAPI="4"

OFED_VER="1.5.4.1"
OFED_SUFFIX="1.20.g6771d22"
OFED_SNAPSHOT="1"

inherit openib

DESCRIPTION="OpenIB userspace driver for Mellanox ConnectX HCA"
KEYWORDS="~amd64 ~x86 ~amd64-linux"
IUSE=""

DEPEND="
	sys-infiniband/libibverbs:${SLOT}
	"
RDEPEND="
		!sys-infiniband/openib-userspace"
block_other_ofed_versions
