# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-mga/xf86-video-mga-1.6.3.ebuild,v 1.1 2013/12/06 10:36:00 chithanh Exp $

EAPI=4
XORG_DRI=dri
inherit xorg-2

DESCRIPTION="Matrox video driver"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux"

src_configure() {
	XORG_CONFIGURE_OPTIONS="$(use_enable dri)"
	xorg-2_src_configure
}
