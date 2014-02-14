# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/ZMQ-LibZMQ2/ZMQ-LibZMQ2-1.40.0.ebuild,v 1.3 2014/01/19 16:58:38 zlogene Exp $

EAPI=5

MODULE_AUTHOR=DMAKI
MODULE_VERSION=1.04
inherit perl-module

DESCRIPTION="A libzmq 2.x wrapper for Perl"

SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~x86"
IUSE="test"

RDEPEND="
	=net-libs/zeromq-2*
	>=dev-perl/ZMQ-Constants-1.0.0
	>=virtual/perl-XSLoader-0.20.0
"
DEPEND="${RDEPEND}
	 dev-perl/Task-Weaken
	>=virtual/perl-ExtUtils-MakeMaker-6.360.0
	virtual/pkgconfig
	test? (
		dev-perl/Test-Requires
		dev-perl/Test-Fatal
		>=dev-perl/Test-TCP-1.80.0
		>=virtual/perl-Test-Simple-0.980.0
	)
"

SRC_TEST=do
