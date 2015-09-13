# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/dataenc/dataenc-0.14.0.5-r1.ebuild,v 1.5 2015/02/01 22:55:34 qnikst Exp $

EAPI=5

# ebuild generated by hackport 0.3.4.9999

CABAL_FEATURES="bin lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Data encoding library"
HOMEPAGE="http://www.haskell.org/haskellwiki/Library/Data_encoding"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~amd64-linux ~ppc-macos ~x86-macos"
IUSE="test"

RDEPEND=">=dev-lang/ghc-6.10.4:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.6.0.3
	test? ( dev-haskell/hunit:=[profile?]
			>=dev-haskell/quickcheck-2.5:=[profile?] <dev-haskell/quickcheck-2.7:=[profile?]
			dev-haskell/test-framework:=[profile?]
			dev-haskell/test-framework-hunit:=[profile?]
			dev-haskell/test-framework-quickcheck2:=[profile?]
			dev-haskell/test-framework-th:=[profile?] )
"

src_prepare() {
	# allow ghc-7.7.2013+
	cabal_chdeps \
		'array >= 0.1.0 && < 0.5' 'array >= 0.1.0 && < 0.6' \
		'base >= 3.0.0 && < 4.7' 'base >= 3' \
		'QuickCheck ==2.5.*' 'QuickCheck >=2.5 && <2.7'
}

src_configure() {
	haskell-cabal_src_configure \
		$(cabal_flag test tests)
}