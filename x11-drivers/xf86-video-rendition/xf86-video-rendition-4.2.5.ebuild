# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-rendition/xf86-video-rendition-4.2.5.ebuild,v 1.7 2013/03/12 16:36:45 chithanh Exp $

EAPI=4
inherit xorg-2

DESCRIPTION="Rendition video driver"
KEYWORDS="alpha amd64 ia64 x86 ~amd64-fbsd ~x86-fbsd"
IUSE=""

RDEPEND=">=x11-base/xorg-server-1.0.99"
DEPEND="${RDEPEND}"
