# Copyright 2011 Hacking Networked Solutions
# Distributed under the terms of the GNU General Public License v3
# $Header$

EAPI="3"

DESCRIPTION="An SNMP extension script to provide access to MD-RAID array state data"
HOMEPAGE="http://www.mad-hacking.net/software/linux/agnostic/snmpd-mdraid-connector/index.xml"
SRC_URI="http://downloads.mad-hacking.net/software/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=dev-libs/snmpd-connector-lib-0.3
		 dev-libs/hacking-bash-lib
		 snmp-mibs/mdraid-snmp-mib
		 net-analyzer/net-snmp
		 sys-fs/mdadm"

src_install() {
	exeinto /usr/sbin
	doexe usr/sbin/*

	insinto /etc
	doins etc/*

	keepdir /var/cache/snmp
}