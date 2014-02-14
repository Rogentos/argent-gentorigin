# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-djvulibre/python-djvulibre-0.3.9.ebuild,v 1.3 2013/02/28 16:18:38 pinkbyte Exp $

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="Set of Python bindings for the DjVuLibre library"
HOMEPAGE="http://jwilk.net/software/python-djvulibre"
SRC_URI="mirror://pypi/p/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="app-text/djvu"
DEPEND="${RDEPEND}
	dev-python/cython"
