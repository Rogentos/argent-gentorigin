# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/systemu/systemu-2.6.5.ebuild,v 1.1 2015/03/27 20:01:19 mrueg Exp $

EAPI=5
# Test hangs on jruby
USE_RUBY="ruby19 ruby20 ruby21 ruby22"

RUBY_FAKEGEM_TASK_DOC=""

RUBY_FAKEGEM_EXTRADOC="README"

inherit ruby-fakegem

DESCRIPTION="Universal capture of STDOUT and STDERR and handling of child process PID"
HOMEPAGE="http://codeforpeople.com/lib/ruby/systemu/"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

all_ruby_install() {
	all_fakegem_install

	insinto /usr/share/doc/${PF}
	doins -r samples
}