# Copyright 2012 Hacking Networked Solutions
# Distributed under the terms of the GNU General Public License v3

EAPI="3"

DESCRIPTION="Hacking Networked Solutions log server meta-package"
HOMEPAGE="http://www.hacking.co.uk/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
RDEPEND="${DEPEND}
	install-meta/hacking-base-server
	dev-db/mysql
	dev-lang/php
	net-analyzer/cacti
	net-analyzer/cacti-spine
	snmp-mibs/mdraid-snmp-mib
	snmp-mibs/smartctl-snmp-mib
	www-servers/apache"