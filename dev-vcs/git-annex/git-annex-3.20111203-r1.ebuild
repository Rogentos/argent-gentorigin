# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/git-annex/git-annex-3.20111203-r1.ebuild,v 1.5 2012/12/07 10:39:18 slyfox Exp $

# ebuild generated by hackport 0.2.13

EAPI="3"

CABAL_FEATURES="bin"
inherit haskell-cabal

DESCRIPTION="manage files with git, without checking their contents into git"
HOMEPAGE="http://git-annex.branchable.com/"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND=">=dev-vcs/git-1.7.7" # TODO: add more deps?
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.6
		dev-haskell/dataenc
		dev-haskell/hs3
		dev-haskell/hslogger
		dev-haskell/http
		dev-haskell/json[generic]
		dev-haskell/missingh
		dev-haskell/monad-control
		>=dev-haskell/mtl-2
		dev-haskell/network
		dev-haskell/pcre-light
		dev-haskell/sha
		dev-haskell/utf8-string
		>=dev-lang/ghc-6.10.1
		dev-lang/perl
		doc? ( www-apps/ikiwiki net-misc/rsync )"
# dev-lang/perl is to build the manpages
# www-apps/ikiwiki and net-misc/rsync used to build the rest of the docs

src_prepare() {
	echo 'mans: $(mans)' >>"${S}"/Makefile
}

src_compile() {
	haskell-cabal_src_compile
	use doc && emake docs
	emake mans
}

src_install() {
	#haskell-cabal_src_install
	emake install DESTDIR="${D}" PREFIX="${EPREFIX}/usr"
	mv "${ED}"/usr/share/doc/{${PN},${PF}}
	dodoc CHANGELOG README
}