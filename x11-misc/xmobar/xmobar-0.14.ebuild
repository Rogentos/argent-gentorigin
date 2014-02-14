# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xmobar/xmobar-0.14.ebuild,v 1.5 2012/12/07 10:41:15 slyfox Exp $

# ebuild generated by hackport 0.2.14

EAPI="3"

CABAL_FEATURES="bin"
inherit base haskell-cabal

DESCRIPTION="A Minimalistic Text Based Status Bar"
HOMEPAGE="http://projects.haskell.org/xmobar/"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="xft unicode mail mpd alsa timezone"
# wifi USE flag disabled due to compilation error with current stable wireless-tools.

RDEPEND="x11-libs/libXrandr
	mpd? ( media-sound/mpd )
	"

DEPEND="${RDEPEND}
		>=dev-lang/ghc-7.0.1
		>=dev-haskell/cabal-1.6
		dev-haskell/mtl
		>=dev-haskell/parsec-3
		dev-haskell/stm
		>=dev-haskell/x11-1.3.0
		unicode? ( dev-haskell/utf8-string )
		xft?  ( dev-haskell/utf8-string
				dev-haskell/x11-xft )
		mail? ( dev-haskell/hinotify )
		mpd? ( >=dev-haskell/libmpd-0.6 )
		alsa? ( =dev-haskell/alsa-mixer-0.1*
			=dev-haskell/alsa-core-0.5*
		)
		timezone? ( dev-haskell/timezone-series
			dev-haskell/timezone-olson
		)
		"
		#wifi? ( net-wireless/wireless-tools )

PATCHES=("${FILESDIR}/${PN}-0.14-stm-2.3.patch")

src_configure() {
	cabal_src_configure \
		$(cabal_flag xft with_xft) \
		$(cabal_flag unicode with_utf8) \
		$(cabal_flag mail with_inotify) \
		$(cabal_flag mpd with_mpd) \
		$(cabal_flag alsa with_alsa) \
		$(cabal_flag timezone with_datezone)
		#$(cabal_flag wifi with_iwlib) \
}

src_install() {
	cabal_src_install

	dodoc samples/xmobar.config README
}
