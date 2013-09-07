# Copyright 2012 Hacking Networked Solutions
# Distributed under the terms of the GNU General Public License v3
# $Header: $

EAPI="3"

DESCRIPTION="Additional vif scripts for Xen"
HOMEPAGE="http://www.mad-hacking.net/"
SRC_URI="http://downloads.mad-hacking.net/software/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="app-emulation/xen-tools"

src_install() {
	exeinto /etc/xen/scripts
	doexe etc/xen/scripts/*
}