# Copyright 2013 Hacking Networked Solutions
# Distributed under the terms of the GNU General Public License v3
# $Header: $

EAPI="3"

DESCRIPTION="Dracut module to boot from Rados Block Device (RBD - Ceph)"
HOMEPAGE="http://www.mad-hacking.net/software/"
SRC_URI="http://downloads.mad-hacking.net/software/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="sys-cluster/ceph
		sys-kernel/dracut"

src_install() {
	cp -a ${WORKDIR}/${P}/* ${D}/
}
