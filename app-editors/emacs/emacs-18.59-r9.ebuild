# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/emacs/emacs-18.59-r9.ebuild,v 1.2 2014/01/25 16:11:17 ulm Exp $

EAPI=5

inherit eutils toolchain-funcs flag-o-matic multilib

DESCRIPTION="The extensible self-documenting text editor"
HOMEPAGE="http://www.gnu.org/software/emacs/"
SRC_URI="mirror://gnu/old-gnu/emacs/${P}.tar.gz
	ftp://ftp.splode.com/pub/users/friedman/emacs/${P}-linux22x-elf-glibc21.diff.gz
	http://dev.gentoo.org/~ulm/emacs/${P}-patches-8.tar.bz2"

LICENSE="GPL-1+ GPL-2+ BSD" #HPND
SLOT="18"
KEYWORDS="~amd64 ~x86"
IUSE="+abi_x86_32 abi_x86_x32"
REQUIRED_USE="amd64? ( || ( abi_x86_32 abi_x86_x32 ) )"

RDEPEND="sys-libs/ncurses
	>=app-admin/eselect-emacs-1.2
	amd64? (
		sys-libs/ncurses[abi_x86_x32(-)?]
		!abi_x86_x32? ( sys-libs/ncurses[abi_x86_32(-)?] )
	)"
#	X? ( x11-libs/libX11[-xcb] )
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	epatch "${WORKDIR}/${P}-linux22x-elf-glibc21.diff"
	EPATCH_SUFFIX=patch epatch
	epatch_user
}

src_configure() {
	# autoconf? What's autoconf? We are living in 1992. ;-)
	local arch
	case ${ARCH} in
		amd64)
			if use abi_x86_x32; then
				arch=x86-x32
				multilib_toolchain_setup x32
			elif use abi_x86_32; then
				arch=intel386
				multilib_toolchain_setup x86
			else
				die "Need 32 bit ABI on amd64"
			fi
			;;
		x86) arch=intel386 ;;
		*) die "Architecture ${ARCH} not yet supported" ;;
	esac
	local cmd="s/\"s-.*\.h\"/\"s-linux.h\"/;s/\"m-.*\.h\"/\"m-${arch}.h\"/"
	#use X && cmd="${cmd};s/.*\(#define HAVE_X_WINDOWS\).*/\1/"
	sed -e "${cmd}" src/config.h-dist >src/config.h || die

	cat <<-END >src/paths.h
		#define PATH_LOADSEARCH "/usr/share/emacs/${PV}/lisp"
		#define PATH_EXEC "/usr/share/emacs/${PV}/etc"
		#define PATH_LOCK "/var/lib/emacs/lock/"
		#define PATH_SUPERLOCK "/var/lib/emacs/lock/!!!SuperLock!!!"
	END

	sed -i -e "s:/usr/lib/\([^ ]*\).o:/usr/$(get_libdir)/\1.o:g" \
		-e "s:-lncurses:$("$(tc-getPKG_CONFIG)" --libs ncurses):" \
		src/s-linux.h || die

	# -O3 and -finline-functions cause segmentation faults at run time.
	filter-flags -finline-functions
	replace-flags -O[3-9] -O2
	strip-flags
}

src_compile() {
	# Do not use the sandbox, or the dumped Emacs will be twice as large
	export SANDBOX_ON=0
	emake --jobs=1 \
		CC="$(tc-getCC)" CFLAGS="${CFLAGS} -Demacs" \
		LD="$(tc-getCC) -nostdlib" LDFLAGS="${LDFLAGS}"
}

src_install() {
	local basedir="/usr/share/emacs/${PV}" i

	dodir ${basedir}
	dodir /usr/share/man/man1
	emake --jobs=1 \
		LIBDIR="${D}"${basedir} \
		BINDIR="${D}"/usr/bin \
		MANDIR="${D}"/usr/share/man/man1 \
		install

	rmdir "${D}"${basedir}/lock || die
	find "${D}"${basedir} -type f \( -name "*.c" -o -name ChangeLog \
		-o -name COPYING ! -path "*/etc/COPYING" \) -exec rm "{}" + || die
	fperms -R go-w ${basedir}

	# remove duplicate DOC file
	rm "${D}"${basedir}/etc/DOC || die

	# move executables to the correct place
	mv "${D}"/usr/bin/emacs{,-${SLOT}} || die
	for i in etags ctags emacsclient; do
		mv "${D}"/usr/bin/${i}{,-emacs-${SLOT}} || die
		rm "${D}"${basedir}/etc/${i} || die
	done

	dodir /usr/libexec/emacs/${PV}
	for i in wakeup digest-doc sorted-doc movemail cvtmail fakemail \
		yow env server
	do
		mv "${D}"${basedir}/etc/${i} "${D}"/usr/libexec/emacs/${PV}/${i} || die
		dosym ../../../../libexec/emacs/${PV}/${i} ${basedir}/etc/${i}
	done
	for i in test-distrib make-docfile; do
		rm "${D}"${basedir}/etc/${i} || die
	done

	# move man page
	mv "${D}"/usr/share/man/man1/emacs{,-emacs-${SLOT}}.1 || die

	# move Info files
	dodir /usr/share/info
	mv "${D}"${basedir}/info "${D}"/usr/share/info/emacs-${SLOT} || die
	dosym ../../info/emacs-${SLOT} "${basedir}"/info
	docompress -x /usr/share/info

	# move Info dir to avoid collisions with the dir file generated by portage
	mv "${D}"/usr/share/info/emacs-${SLOT}/dir{,.orig} || die
	touch "${D}"/usr/share/info/emacs-${SLOT}/.keepinfodir

	dodir /var/lib/emacs
	diropts -m0777
	keepdir /var/lib/emacs/lock

	dodoc README PROBLEMS
}

pkg_preinst() {
	# move Info dir file to correct name
	if [[ -d "${D}"/usr/share/info ]]; then
		mv "${D}"/usr/share/info/emacs-${SLOT}/dir{.orig,} || die
	fi

	# remove symlink and directory installed by -r6 and earlier
	if [[ -L "${ROOT}"/usr/share/info/emacs-${SLOT} ]]; then
		ewarn "Removing old symlink /usr/share/info/emacs-${SLOT}"
		rm "${ROOT}"/usr/share/info/emacs-${SLOT} || die
	fi
	if [[ -d "${ROOT}"/usr/share/emacs/${PV}/info \
		&& ! -L "${ROOT}"/usr/share/emacs/${PV}/info ]]; then
		ewarn "Removing old directory /usr/share/emacs/${PV}/info"
		rm -r "${ROOT}"/usr/share/emacs/${PV}/info || die
	fi
}

pkg_postinst() {
	eselect emacs update ifunset
}

pkg_postrm() {
	eselect emacs update ifunset
}
