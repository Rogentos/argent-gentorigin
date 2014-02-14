# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/rackspace-novaclient/rackspace-novaclient-9999.ebuild,v 1.4 2013/05/03 18:52:07 prometheanfire Exp $

EAPI=5
PYTHON_COMPAT=( python2_6 python2_7 )

inherit distutils-r1 git-2

EGIT_REPO_URI="git://github.com/rackerlabs/${PN}.git
	https://github.com/rackerlabs/${PN}.git"

DESCRIPTION="This is a client for the OpenStack Nova API."
HOMEPAGE="https://github.com/rackspace/rackspace-novaclient"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="dev-python/python-novaclient[${PYTHON_USEDEP}]
		dev-python/rackspace-auth-openstack[${PYTHON_USEDEP}]
		dev-python/os-diskconfig-python-novaclient-ext[${PYTHON_USEDEP}]
		dev-python/rax-backup-schedule-python-novaclient-ext[${PYTHON_USEDEP}]
		dev-python/os-networksv2-python-novaclient-ext[${PYTHON_USEDEP}]
		dev-python/rax-default-network-flags-python-novaclient-ext[${PYTHON_USEDEP}]"

python_prepare() {
	mkdir "${BUILD_DIR}" || die
}
