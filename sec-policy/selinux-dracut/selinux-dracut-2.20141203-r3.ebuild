# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-dracut/selinux-dracut-2.20141203-r3.ebuild,v 1.2 2015/03/22 14:17:14 swift Exp $
EAPI="5"

IUSE=""
MODS="dracut"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for dracut"

if [[ $PV == 9999* ]] ; then
	KEYWORDS=""
else
	KEYWORDS="amd64 x86"
fi