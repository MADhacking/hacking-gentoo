# Copyright 2010 Hacking Networked Solutions
# Distributed under the terms of the GNU General Public License v3
# $Header: $

EAPI="3"

DESCRIPTION="Definitions of Managed Objects for Network Time Protocol Version 4 (NTPv4) - RFC 5907"
HOMEPAGE="http://tools.ietf.org/html/rfc5907"
SRC_URI="http://downloads.mad-hacking.net/software/${P}.tar.bz2"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~amd64-fbsd ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~sparc-fbsd x86 ~x86-fbsd"
IUSE=""

RDEPEND="snmp-mibs/sysappl-snmp-mib"

src_install() {
	insinto /usr/share/snmp/mibs
	doins usr/share/snmp/mibs/*
}