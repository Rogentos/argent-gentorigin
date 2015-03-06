# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/mpmath/mpmath-0.19.ebuild,v 1.3 2014/08/05 08:16:24 idella4 Exp $

EAPI=5

PYTHON_COMPAT=( python{2_7,3_2,3_3,3_4} )

inherit distutils-r1 eutils

MY_PN=${PN}-all
MY_P=${MY_PN}-${PV}

DESCRIPTION="Python library for arbitrary-precision floating-point arithmetic"
HOMEPAGE="http://mpmath.org/"
SRC_URI="http://mpmath.org/files/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86 ~amd64-linux ~ppc-macos ~x64-macos ~x86-linux ~x86-macos"

IUSE="doc examples gmp matplotlib test"

RDEPEND="
	gmp? ( dev-python/gmpy )
	matplotlib? ( dev-python/matplotlib[${PYTHON_USEDEP}] )"
DEPEND="${RDEPEND}
	doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )
	test? ( dev-python/pytest[${PYTHON_USEDEP}] )"

S="${WORKDIR}/${MY_P}"

python_prepare_all() {
	local PATCHES=(
		"${FILESDIR}/${PN}.patch"
		)

	# this fails with the current version of dev-python/py
	rm ${PN}/conftest.py || die

	# this test requires X
	rm ${PN}/tests/test_visualization.py || die

	distutils-r1_python_prepare_all
}

python_compile_all() {
	if use doc; then
		einfo "Generation of documentation"
		cd doc || die
		"${PYTHON}" build.py || die "Generation of documentation failed"
	fi
}

python_test() {
	py.test -v || die
}

python_install_all() {
	use doc && local HTML_DOCS=( doc/build/. )
	use examples && local EXAMPLES=( demo/. )
	distutils-r1_python_install_all
}