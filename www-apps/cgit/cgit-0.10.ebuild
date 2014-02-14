# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/cgit/cgit-0.10.ebuild,v 1.2 2014/02/05 16:32:50 zx2c4 Exp $

EAPI="4"

WEBAPP_MANUAL_SLOT="yes"

inherit webapp eutils multilib user

[[ -z "${CGIT_CACHEDIR}" ]] && CGIT_CACHEDIR="/var/cache/${PN}/"

GIT_V="1.8.5"

DESCRIPTION="a fast web-interface for git repositories"
HOMEPAGE="http://git.zx2c4.com/cgit/about"
SRC_URI="mirror://kernel/software/scm/git/git-${GIT_V}.tar.bz2
	http://git.zx2c4.com/cgit/snapshot/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="doc +highlight +lua +jit"

RDEPEND="
	dev-vcs/git
	sys-libs/zlib
	dev-libs/openssl
	virtual/httpd-cgi
	highlight? ( || ( dev-python/pygments app-text/highlight ) )
	lua? ( jit? ( dev-lang/luajit ) !jit? ( dev-lang/lua ) )
"
# ebuilds without WEBAPP_MANUAL_SLOT="yes" are broken
DEPEND="${RDEPEND}
	!<www-apps/cgit-0.8.3.3
	doc? ( app-text/docbook-xsl-stylesheets
		>=app-text/asciidoc-8.5.1 )
"

pkg_setup() {
	webapp_pkg_setup
	enewuser "${PN}"
}

src_prepare() {
	rmdir git || die
	mv "${WORKDIR}"/git-"${GIT_V}" git || die

	echo "prefix = ${EPREFIX}/usr" >> cgit.conf
	echo "libdir = ${EPREFIX}/usr/$(get_libdir)" >> cgit.conf
	echo "CGIT_SCRIPT_PATH = ${MY_CGIBINDIR}" >> cgit.conf
	echo "CGIT_DATA_PATH = ${MY_HTDOCSDIR}" >> cgit.conf
	echo "CACHE_ROOT = ${CGIT_CACHEDIR}" >> cgit.conf
	echo "DESTDIR = ${D}" >> cgit.conf
	if use lua; then
		if use jit; then
			echo "LUA_IMPLEMENTATION = JIT" >> cgit.conf
		else
			echo "LUA_IMPLEMENTATION = VANILLA" >> cgit.conf
		fi
	else
		echo "NO_LUA = 1" >> cgit.conf
	fi
}

src_compile() {
	emake
	use doc && emake doc-man
}

src_install() {
	webapp_src_preinst

	emake install

	insinto /etc
	doins "${FILESDIR}"/cgitrc

	dodoc README
	use doc && doman cgitrc.5

	webapp_postinst_txt en "${FILESDIR}"/postinstall-en.txt
	webapp_src_install

	keepdir "${CGIT_CACHEDIR}"
	fowners ${PN}:${PN} "${CGIT_CACHEDIR}"
	fperms 700 "${CGIT_CACHEDIR}"
}

pkg_postinst() {
	webapp_pkg_postinst
	ewarn "If you intend to run cgit using web server's user"
	ewarn "you should change ${CGIT_CACHEDIR} permissions."
}
