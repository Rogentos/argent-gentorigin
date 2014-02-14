# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/icalendar/icalendar-3.3.ebuild,v 1.3 2013/09/05 18:46:16 mgorny Exp $

EAPI="5"

PYTHON_COMPAT=( python{2_6,2_7} pypy2_0 )

inherit distutils-r1

MY_PN="collective-${PN}"

DESCRIPTION="Package used for parsing and generating iCalendar files (RFC 2445)."
HOMEPAGE="http://github.com/collective/icalendar"
SRC_URI="mirror://pypi/i/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-fbsd"
IUSE="doc test"
DOCS="README.rst"

RDEPEND=""
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	doc? ( dev-python/sphinx
	dev-python/pytz )
	test? ( virtual/python-unittest2[${PYTHON_USEDEP}]
	>=dev-python/python-dateutil-1.5[${PYTHON_USEDEP}] )"

python_compile_all() {
	if use doc; then
		pushd docs > /dev/null
		emake text
		popd > /dev/null
		DOCS=( ${DOCS} docs/_build/text/*.txt )
	fi
}

python_test() {
	nosetests -v src/icalendar/tests
}
