# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-memcached/python-memcached-1.53-r1.ebuild,v 1.2 2013/10/22 14:23:40 grobian Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} pypy2_0 )

inherit distutils-r1

DESCRIPTION="Pure python memcached client"
HOMEPAGE="http://www.tummy.com/Community/software/python-memcached/ http://pypi.python.org/pypi/python-memcached"
SRC_URI="ftp://ftp.tummy.com/pub/python-memcached/old-releases/${P}.tar.gz"

LICENSE="OSL-2.0"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux ~x64-macos ~x86-macos"
IUSE="test"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( net-misc/memcached )"
RDEPEND=""

# Tests try to connect to memcached via TCP/IP. Please do not re-enable
# until you get them all to pass properly while using the UNIX socket
# only and not even trying to connect to memcached over TCP/IP.
RESTRICT=test

python_test() {
	# Note: partial. Needs fixing. Stuff like that.

	cd "${TMPDIR}" || die

	local memcached_opts=( -d -P memcached.pid -s memcached.socket )
	[[ ${EUID} == 0 ]] && memcached_opts+=( -u portage )

	memcached "${memached_opts[@]}" || die

	"${PYTHON}" memcache.py --do-unix || die "Tests fail with ${EPYTHON}"

	kill "$(<memcached.pid)" || die
	rm memcached.pid || die
}
