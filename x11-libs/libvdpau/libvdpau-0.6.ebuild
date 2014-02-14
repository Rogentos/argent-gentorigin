# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libvdpau/libvdpau-0.6.ebuild,v 1.2 2013/07/30 18:59:24 mgorny Exp $

EAPI=5
inherit autotools-multilib

DESCRIPTION="VDPAU wrapper and trace libraries"
HOMEPAGE="http://www.freedesktop.org/wiki/Software/VDPAU"
SRC_URI="http://people.freedesktop.org/~aplattner/vdpau/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~x86 ~amd64-fbsd ~x86-fbsd"
IUSE="doc dri"

RDEPEND="x11-libs/libX11[${MULTILIB_USEDEP}]
	dri? ( x11-libs/libXext[${MULTILIB_USEDEP}] )
	!=x11-drivers/nvidia-drivers-180*
	!=x11-drivers/nvidia-drivers-185*
	!=x11-drivers/nvidia-drivers-190*
	abi_x86_32? ( !app-emulation/emul-linux-x86-xlibs[-abi_x86_32(-)] )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	doc? (
		app-doc/doxygen
		media-gfx/graphviz
		virtual/latex-base
		)
	dri? ( >=x11-proto/dri2proto-2.2 )"

src_configure() {
	local myeconfargs=(
		--docdir="${EPREFIX}"/usr/share/doc/${PF}
		$(use_enable doc documentation)
		$(use dri || echo --disable-dri2)
	)

	autotools-multilib_src_configure
}

src_install() {
	autotools-multilib_src_install
	prune_libtool_files --modules
}
