# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/xapian/xapian-1.2.15.ebuild,v 1.1 2013/08/12 11:56:55 blueness Exp $

EAPI="5"

MY_P="${PN}-core-${PV}"

DESCRIPTION="Xapian Probabilistic Information Retrieval library"
HOMEPAGE="http://www.xapian.org/"
SRC_URI="http://oligarchy.co.uk/xapian/${PV}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc static-libs -sse +sse2 +brass +chert +inmemory"

DEPEND="sys-libs/zlib"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_configure() {
	local myconf=""

	ewarn
	if use sse2; then
		ewarn "Using sse2"
		myconf="${myconf} --enable-sse=sse2"
	else
		if use sse; then
			ewarn "Using sse"
			myconf="${myconf} --enable-sse=sse"
		else
			ewarn "Disabling sse and sse2"
			myconf="${myconf} --disable-sse"
		fi
	fi
	ewarn

	myconf="${myconf} $(use_enable static-libs static)"

	use brass || myconf="${myconf} --disable-backend-brass"
	use chert || myconf="${myconf} --disable-backend-chert"
	use inmemory || myconf="${myconf} --disable-backend-inmemory"

	myconf="${myconf} --enable-backend-flint --enable-backend-remote"

	econf $myconf
}

src_install() {
	emake DESTDIR="${D}" install

	mv "${D}usr/share/doc/xapian-core" "${D}usr/share/doc/${PF}"
	use doc || rm -rf "${D}usr/share/doc/${PF}"

	dodoc AUTHORS HACKING PLATFORMS README NEWS
}

src_test() {
	emake check VALGRIND=
}
