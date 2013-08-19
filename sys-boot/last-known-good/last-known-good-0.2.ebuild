# Copyright 2012 Hacking Networked Solutions
# Distributed under the terms of the GNU General Public License v3
# $Header: $

EAPI="3"

DESCRIPTION="Last Known Good system using LVM snapshots (user tools)"
HOMEPAGE="http://www.mad-hacking.net/software/"
SRC_URI="http://downloads.mad-hacking.net/software/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND="sys-apps/openrc-runhooks-plugin"

src_install() {
	cp -a ${WORKDIR}/${P}/* ${D}/
}
