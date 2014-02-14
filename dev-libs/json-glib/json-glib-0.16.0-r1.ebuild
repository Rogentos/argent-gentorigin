# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/json-glib/json-glib-0.16.0-r1.ebuild,v 1.2 2013/08/27 21:30:07 aballier Exp $

EAPI=5
GCONF_DEBUG=yes

inherit autotools eutils gnome2

DESCRIPTION="A library providing GLib serialization and deserialization support for the JSON format"
HOMEPAGE="https://wiki.gnome.org/JsonGlib"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86 ~amd64-fbsd ~x86-fbsd"
IUSE="+introspection"

RDEPEND="
	>=dev-libs/glib-2.34.0:2
	introspection? ( >=dev-libs/gobject-introspection-0.9.5 )
"
DEPEND="${RDEPEND}
	>=dev-util/gtk-doc-am-1.13
	>=sys-devel/gettext-0.18
	virtual/pkgconfig
"

src_prepare() {
	# Add configure option to enable -Bsymbolic (from 'master')
	epatch "${FILESDIR}/${PN}-0.16.0-bsymbolic.patch"
	eautoreconf
	gnome2_src_prepare
}

src_configure() {
	# Coverage support is useless, and causes runtime problems
	gnome2_src_configure \
		--disable-gcov \
		$(use_enable introspection)
}
