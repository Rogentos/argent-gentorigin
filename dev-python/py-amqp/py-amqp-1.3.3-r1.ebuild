# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/py-amqp/py-amqp-1.3.3-r1.ebuild,v 1.1 2013/12/18 13:21:58 idella4 Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} pypy2_0 )

inherit distutils-r1

MY_PN="amqp"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Low-level AMQP client for Python (fork of amqplib)"
HOMEPAGE="https://github.com/celery/py-amqp http://pypi.python.org/pypi/amqp/"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

S="${WORKDIR}/${MY_P}"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples extras test"

RDEPEND=""
DEPEND="test? ( virtual/python-unittest2[${PYTHON_USEDEP}]
		dev-python/nose[${PYTHON_USEDEP}]
		dev-python/nose-cover3[${PYTHON_USEDEP}]
		>=dev-python/coverage-3.0[${PYTHON_USEDEP}]
		dev-python/mock[${PYTHON_USEDEP}]
		)"

# Same tests from before require a socket connection
PATCHES=( "${FILESDIR}"/${P}-disable_socket_tests.patch )

python_compile_all() {
	use doc && emake -C docs html
}

python_test() {
	cp -r -l funtests "${BUILD_DIR}"/lib/ || die
	cd "${BUILD_DIR}"/lib || die
	if [[ ${EPYTHON:6:1} == 3 ]]; then
		#   -n causes Python to write into hardlinked files
		2to3 --no-diffs -w funtests || die
	fi
	"${PYTHON}" funtests/run_all.py || ewarn "Tests failed under ${EPYTHON}"
	rm -rf funtests/ || die
}

python_install_all() {
	use examples && local EXAMPLES=( demo/. )
	use doc && local HTML_DOCS=( docs/.build/html/. )
	if use extras; then
		insinto /usr/share/${PF}/extras
		doins -r extra
	fi
	distutils-r1_python_install_all
}
