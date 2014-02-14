# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/robotframework-sshlibrary/robotframework-sshlibrary-1.1.ebuild,v 1.1 2013/02/26 01:51:34 radhermit Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

DESCRIPTION="A test library for Robot Framework that enables SSH and SFTP"
HOMEPAGE="http://code.google.com/p/robotframework-sshlibrary/"
SRC_URI="http://robotframework-sshlibrary.googlecode.com/files/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/paramiko[${PYTHON_USEDEP}]
	dev-python/robotframework[${PYTHON_USEDEP}]"

DOCS=( README.txt )
