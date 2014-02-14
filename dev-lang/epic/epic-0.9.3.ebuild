# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/epic/epic-0.9.3.ebuild,v 1.4 2012/11/18 06:53:41 gienah Exp $

EAPI=5

# ebuild generated by hackport 0.3.9999

CABAL_FEATURES="bin lib profile haddock hoogle hscolour"
inherit base haskell-cabal

DESCRIPTION="Compiler for a simple functional language"
HOMEPAGE="http://www.dcs.st-and.ac.uk/~eb/epic.php"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-haskell/cabal:=[profile?]
		dev-haskell/mtl:=[profile?]
		>=dev-libs/boehm-gc-7.0[threads]
		>=dev-lang/ghc-6.10.4:="
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.8.0.4
		dev-haskell/happy"

PATCHES=("${FILESDIR}/${PN}-0.9.3-ghc-7.6.patch")
