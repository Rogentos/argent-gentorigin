# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/abi-compliance-checker/abi-compliance-checker-1.98.7.ebuild,v 1.1 2013/01/07 13:40:04 mgorny Exp $

EAPI=4

DESCRIPTION="A tool for checking backward compatibility of a C/C++ library"
HOMEPAGE="http://ispras.linuxbase.org/index.php/ABI_compliance_checker"
SRC_URI="https://github.com/lvc/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_install() {
	mkdir -p "${D}"/usr || die
	perl Makefile.pl --install --prefix=/usr --destdir="${D}" || die
}
