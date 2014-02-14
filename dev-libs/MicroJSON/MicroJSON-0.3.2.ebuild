# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/MicroJSON/MicroJSON-0.3.2.ebuild,v 1.2 2013/09/04 11:31:19 pinkbyte Exp $

EAPI="5"

inherit cmake-utils

DESCRIPTION="Small and simple to use JSON generation and parsing library."
HOMEPAGE="http://grigory.info/${PN}.About.html"
SRC_URI="http://grigory.info/distfiles/${P}.tar.bz2"

LICENSE="GPL-3"
KEYWORDS="~amd64 ~mips ~x86 ~amd64-linux ~x86-linux"
SLOT="0"

RDEPEND=">=dev-libs/UTF8Strings-1.12.0"

DEPEND="${RDEPEND}"
