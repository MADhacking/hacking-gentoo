# Copyright 2010 Hacking Networked Solutions
# Distributed under the terms of the GNU General Public License v3
# $Header$

EAPI="3"

DESCRIPTION="Configuration fragments and graphics enabling Apache2 to prevent hot-linking"
HOMEPAGE="http://www.mad-hacking.net/software/linux/agnostic/hotlink-deflector/index.xml"
SRC_URI="http://downloads.mad-hacking.net/software/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha amd64 ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~sparc-fbsd x86 ~x86-fbsd"
IUSE=""

RDEPEND="www-servers/apache"

src_install() {
	cp -a ${WORKDIR}/${P}/* ${ED}/
}