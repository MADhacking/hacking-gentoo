# Copyright 2010 Hacking Networked Solutions
# Distributed under the terms of the GNU General Public License v3
# $Header$

EAPI="3"

DESCRIPTION="auto-patch-portage automatically applies various patch-sets to the portage repository"
HOMEPAGE="http://www.mad-hacking.net/software/gentoo/auto-patch-portage/index.xml"
SRC_URI="http://downloads.mad-hacking.net/software/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha amd64 ~amd64-fbsd ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~sparc-fbsd x86 ~x86-fbsd"
IUSE=""

src_install() {
	exeinto /usr/bin
	doexe bin/auto-patch-portage

	insinto /etc
	doins etc/auto-patch-portage
}