# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/javatoolkit/javatoolkit-0.3.0-r9.ebuild,v 1.10 2015/06/14 19:29:57 monsieurp Exp $

EAPI="5"

PYTHON_COMPAT=(python2_7)
PYTHON_REQ_USE="xml(+)"

inherit distutils-r1 eutils multilib

DESCRIPTION="Collection of Gentoo-specific tools for Java"
HOMEPAGE="http://www.gentoo.org/proj/en/java/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86 sparc ~ia64 ~arm ~amd64-fbsd ~x86-fbsd"
IUSE=""

python_prepare_all() {
	local PATCHES=(
		"${FILESDIR}/${P}-python2.6.patch"
		"${FILESDIR}/${P}-no-pyxml.patch"
	)

	distutils-r1_python_prepare_all
}

python_install() {
	distutils-r1_python_install \
		--install-scripts="${EPREFIX}"/usr/$(get_libdir)/${PN}/bin
}