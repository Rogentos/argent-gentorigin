# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/mikutter/mikutter-0.2.2.1410.ebuild,v 1.2 2013/11/18 06:16:52 naota Exp $

EAPI=5

USE_RUBY="ruby19"

inherit ruby-ng eutils

if [ "${PV}" = "9999" ]; then
	EGIT_REPO_URI="git://toshia.dip.jp/mikutter.git"
	inherit git-2
	KEYWORDS=""
	EGIT_SOURCEDIR="${WORKDIR}/all"
else
	MY_P="${PN}.${PV}"
	SRC_URI="http://mikutter.hachune.net/bin/${MY_P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	RUBY_S="${PN}"
fi

DESCRIPTION="mikutter is simple, powerful and moeful twitter client"
HOMEPAGE="http://mikutter.hachune.net/"

LICENSE="GPL-3"
SLOT="0"
IUSE="+libnotify sound"

DEPEND=""
RDEPEND="libnotify? ( x11-libs/libnotify )
	sound? ( media-sound/alsa-utils )"

ruby_add_rdepend "dev-ruby/addressable
	dev-ruby/bsearch
	dev-ruby/json
	dev-ruby/memoize
	>=dev-ruby/oauth-0.4.7
	dev-ruby/ruby-gtk2
	dev-ruby/typed-array
	virtual/ruby-ssl"

all_ruby_unpack() {
	if [ "${PV}" = "9999" ];then
		git-2_src_unpack
	else
		default
	fi
}

each_ruby_install() {
	exeinto /usr/share/mikutter
	doexe mikutter.rb
	insinto /usr/share/mikutter
	doins -r core plugin Gemfile
	exeinto /usr/bin
	doexe "${FILESDIR}"/mikutter
	dodoc README
	make_desktop_entry mikutter Mikutter \
		/usr/share/mikutter/core/skin/data/icon.png
}
