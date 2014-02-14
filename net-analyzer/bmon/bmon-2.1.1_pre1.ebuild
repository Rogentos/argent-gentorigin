# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/bmon/bmon-2.1.1_pre1.ebuild,v 1.6 2013/02/01 15:34:52 jer Exp $

EAPI=5
inherit eutils toolchain-funcs

MY_PV="${PV/_pre/-pre}"
S="${WORKDIR}/${PN}-${MY_PV}"

DESCRIPTION="interface bandwidth monitor"
HOMEPAGE="http://www.infradead.org/~tgr/bmon/"
SRC_URI="http://people.suug.ch/~tgr/bmon/files/${PN}-${MY_PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~sparc ~x86"
IUSE="dbi rrdtool"

DEPEND="
	>=sys-libs/ncurses-5.3-r2
	dev-libs/libnl:1.1
	dbi? ( >=dev-db/libdbi-0.7.2-r1 )
	rrdtool? ( >=net-analyzer/rrdtool-1.2.6-r1 )
"
RDEPEND="${DEPEND}"

DOCS=( ChangeLog )

src_prepare() {
	# gcc4 fix, bug 105343
	epatch "${FILESDIR}"/${PN}-2.1.0-gcc4.diff
	# Don't strip, bug #144370
	epatch "${FILESDIR}"/${PN}-2.1.0-nostrip.patch
	# libnl crap, bug 176378
	epatch "${FILESDIR}"/${PN}-2.1.0-libnl-1.0.patch
	# newer sysfs has symlinks for net class
	epatch "${FILESDIR}"/${PN}-2.1.0-sysfs-symlink.patch
	# verbose build
	epatch "${FILESDIR}"/${PN}-2.1.1-verbose.patch
}

src_configure() {
	econf \
		$(use_enable dbi) \
		$(use_enable rrdtool rrd)
}
src_compile() {
	emake CPPFLAGS="${CXXFLAGS} -I${WORKDIR}/libnl-${NLVER}/include"
}
