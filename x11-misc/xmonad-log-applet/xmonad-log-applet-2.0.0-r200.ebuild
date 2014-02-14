# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xmonad-log-applet/xmonad-log-applet-2.0.0-r200.ebuild,v 1.1 2013/06/07 20:00:08 qnikst Exp $

EAPI=5

inherit autotools gnome2

DESCRIPTION="Gnome and XFCE applet for displaying XMonad log"
HOMEPAGE="https://github.com/alexkay/xmonad-log-applet"
SRC_URI="mirror://github/alexkay/${PN}/${P}.tar.gz"
LICENSE="BSD"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gnome xfce4"

RESTRICT="mirror"

RDEPEND="sys-apps/dbus
	gnome? ( <gnome-base/gnome-panel-3.0 )
	xfce4? ( xfce-base/xfce4-panel )
	dev-libs/glib:2
	dev-haskell/dbus
	x11-libs/gtk+:2"
DEPEND="${RDEPEND}"

src_prepare() {
	eautoreconf
}

src_configure() {
	local myconf
	myconf=""

	use gnome && myconf="${myconf} --with-panel=gnome2"
	use xfce4 && myconf="${myconf} --with-panel=xfce4"

	econf --sysconfdir=/etc ${myconf}
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc AUTHORS.md README.md
	dodoc "${FILESDIR}"/xmonad.hs
}

pkg_postinst() {
	ghc-package_pkg_postinst

	elog "Remember to update your xmonad.hs accordingly"
	elog "a sample xmonad.hs is provided in /usr/share/doc/${PF}"
}
