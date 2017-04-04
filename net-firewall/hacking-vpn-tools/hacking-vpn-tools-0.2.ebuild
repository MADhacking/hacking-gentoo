# Copyright 2013 Hacking Networked Solutions
# Distributed under the terms of the GNU General Public License v3
# $Header: $

EAPI="3"

DESCRIPTION="A collection of utilities to assist deployment of IPsec VPNs"
HOMEPAGE="http://www.mad-hacking.net/software/"
SRC_URI="http://downloads.mad-hacking.net/software/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha amd64 ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~sparc-fbsd x86 ~x86-fbsd"
IUSE=""

RDEPEND="app-shells/bash
		 net-vpn/ipsec-tools
		 sys-apps/grep
		 sys-apps/iproute2
		 sys-apps/sed
		 sys-apps/util-linux"

src_install() {
	exeinto /usr/bin
	doexe usr/bin/*

	insinto /etc/racoon/dynamic
	doins etc/racoon/dynamic/*
}
