# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/devilspie2/devilspie2-0.29.ebuild,v 1.3 2013/06/25 13:00:09 ago Exp $

EAPI=5

# check locales on version bump!
PLOCALES="sv fr pt_BR nl ru fi"
inherit flag-o-matic toolchain-funcs l10n

DESCRIPTION="Devilspie like window matching utility, using LUA for scripting"
HOMEPAGE="http://devilspie2.gusnan.se"
SRC_URI="http://devilspie2.gusnan.se/download/${PN}_${PV}-src.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="debug"

RDEPEND=">=dev-libs/glib-2.32.4:2
	>=dev-lang/lua-5.1.5
	>=x11-libs/gtk+-3.4.4:3
	>=x11-libs/libwnck-3.4.4:3
	x11-libs/libX11"
DEPEND="${RDEPEND}
	sys-devel/gettext
	virtual/pkgconfig
	x11-proto/xproto"

src_prepare() {
	use debug && append-cflags -D_DEBUG
}

src_compile() {
	emake CC=$(tc-getCC) PREFIX="/usr" LANGUAGES="$(l10n_get_locales)"
}

src_install() {
	emake PREFIX="/usr" DESTDIR="${D}" LANGUAGES="$(l10n_get_locales)" install

	dodoc AUTHORS ChangeLog README README.translators TODO VERSION
	doman devilspie2.1
}

pkg_postinst() {
	elog "Default folder for scripts is ~/.config/devilspie2/"
}
