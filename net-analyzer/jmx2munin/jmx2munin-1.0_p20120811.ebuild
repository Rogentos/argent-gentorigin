# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/jmx2munin/jmx2munin-1.0_p20120811.ebuild,v 1.1 2012/08/10 23:33:46 flameeyes Exp $

EAPI=4

inherit eutils java-pkg-2 java-pkg-simple

MY_P="${PN}-gentoo-${PV}"

DESCRIPTION="JMX Monitoring plugin for Munin"
HOMEPAGE="https://github.com/tcurdt/jmx2munin"
SRC_URI="https://github.com/gentoo/jmx2munin/tarball/${MY_P} -> ${MY_P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

CDEPEND="dev-java/jcommander:0"

DEPEND="${CDEPEND}
	>=virtual/jdk-1.6"

RDEPEND="${CDEPEND}
	net-analyzer/munin
	>=virtual/jre-1.6"

S="${WORKDIR}/${MY_P}"

JAVA_SRC_DIR="src/main/java/org/vafer/jmx"
JAVA_GENTOO_CLASSPATH="jcommander"

src_unpack() {
	unpack ${A}
	mv gentoo-${PN}-* ${MY_P}
}

src_install() {
	java-pkg_dojar ${PN}.jar
	java-pkg_dolauncher ${PN} --main org.vafer.jmx.munin.Munin

	exeinto /usr/libexec/munin/plugins
	newexe contrib/${PN}.sh ${PN}_

	dodoc README.md contrib/jmx2munin.cfg/cassandra/nodes_in_cluster

	keepdir /etc/munin/${PN}
}
