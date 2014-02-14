# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/zfs-kmod/zfs-kmod-0.6.0_rc12-r3.ebuild,v 1.4 2013/04/17 13:27:54 ryao Exp $

EAPI="4"

AT_M4DIR="config"
AUTOTOOLS_AUTORECONF="1"
AUTOTOOLS_IN_SOURCE_BUILD="1"

inherit bash-completion-r1 flag-o-matic linux-info linux-mod toolchain-funcs autotools-utils

if [ ${PV} == "9999" ] ; then
	inherit git-2
	EGIT_REPO_URI="git://github.com/zfsonlinux/zfs.git"
else
	inherit eutils versionator
	MY_PV=$(replace_version_separator 3 '-')
	S="${WORKDIR}/zfs-${MY_PV}"
	SRC_URI="mirror://github/zfsonlinux/zfs/zfs-${MY_PV}.tar.gz
		http://dev.gentoo.org/~ryao/dist/${PN}-${MY_PV}-p0.tar.xz"
	KEYWORDS="~amd64"
fi

DESCRIPTION="Linux ZFS kernel module for sys-fs/zfs"
HOMEPAGE="http://zfsonlinux.org/"

LICENSE="CDDL debug? ( GPL-2+ )"
SLOT="0"
IUSE="custom-cflags debug +rootfs"
RESTRICT="test"

DEPEND="
	=sys-kernel/spl-${PV}*
	dev-lang/perl
	virtual/awk
"

RDEPEND="${DEPEND}
	!sys-fs/zfs-fuse
"

pkg_setup() {
	linux-info_pkg_setup
	CONFIG_CHECK="!DEBUG_LOCK_ALLOC
		BLK_DEV_LOOP
		EFI_PARTITION
		IOSCHED_NOOP
		MODULES
		!PAX_KERNEXEC_PLUGIN_METHOD_OR
		ZLIB_DEFLATE
		ZLIB_INFLATE
	"

	use rootfs && \
		CONFIG_CHECK="${CONFIG_CHECK} BLK_DEV_INITRD
			DEVTMPFS"

	kernel_is ge 2 6 26 || die "Linux 2.6.26 or newer required"

	[ ${PV} != "9999" ] && \
		{ kernel_is le 3 8 || die "Linux 3.8 is the latest supported version."; }

	check_extra_config
}

src_prepare() {
	if [ ${PV} != "9999" ]
	then
		# Apply patch set
		EPATCH_SUFFIX="patch" \
		EPATCH_FORCE="yes" \
		epatch "${WORKDIR}/${PN}-${MY_PV}-patches"

		# Cast constant for 32-bit compatibility
		epatch "${FILESDIR}/${PN}-0.6.0_rc14-cast-const-for-32bit-compatibility.patch"

		# Handle missing name length check in Linux VFS
		epatch "${FILESDIR}/${PN}-0.6.0_rc14-vfs-name-length-compatibility.patch"

		# Fix barrier regression on Linux 2.6.37 and later
		epatch "${FILESDIR}/${PN}-0.6.0_rc14-flush-properly.patch"
	fi

	# Remove GPLv2-licensed ZPIOS unless we are debugging
	use debug || sed -e 's/^subdir-m += zpios$//' -i "${S}/module/Makefile.in"

	autotools-utils_src_prepare
}

src_configure() {
	use custom-cflags || strip-flags
	set_arch_to_kernel
	local myeconfargs=(
		--bindir="${EPREFIX}/bin"
		--sbindir="${EPREFIX}/sbin"
		--with-config=kernel
		--with-linux="${KV_DIR}"
		--with-linux-obj="${KV_OUT_DIR}"
		$(use_enable debug)
	)
	autotools-utils_src_configure
}

src_install() {
	dodoc AUTHORS COPYRIGHT DISCLAIMER README.markdown
	autotools-utils_src_install
}

pkg_postinst() {
	linux-mod_pkg_postinst

	if use x86 || use arm
	then
		ewarn "32-bit kernels will likely require increasing vmalloc to"
		ewarn "at least 256M and decreasing zfs_arc_max to some value less than that."
	fi

}
