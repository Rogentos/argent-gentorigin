# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellsun/gkrellsun-1.0.0-r3.ebuild,v 1.3 2011/12/21 08:32:18 phajdan.jr Exp $

EAPI="3"
inherit gkrellm-plugin eutils

IUSE="nls"
DESCRIPTION="A GKrellM plugin that shows sunrise and sunset times."
HOMEPAGE="http://gkrellsun.sourceforge.net/"
SRC_URI="mirror://sourceforge/gkrellsun/${P}.tar.gz"

SLOT="1"
LICENSE="GPL-2"
KEYWORDS="~alpha amd64 ~hppa ~ia64 ~ppc ~sparc x86"

DEPEND="nls? ( sys-devel/gettext )"

PLUGIN_SO=src20/gkrellsun.so

src_prepare() {
	epatch "${FILESDIR}/${P}-reenable.patch"
	epatch "${FILESDIR}/${P}-Respect-LDFLAGS.patch"
}

src_compile() {
	use nls && myconf="$myconf enable_nls=1"
	emake ${myconf}
}
