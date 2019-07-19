# Copyright 2019 Hacking Networked Solutions
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

DESCRIPTION="Dracut module to boot from Rados Block Device (RBD - Ceph)"
HOMEPAGE="http://www.mad-hacking.net/software/"
SRC_URI="http://downloads.mad-hacking.net/software/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="arm amd64 x86"
IUSE=""

RDEPEND="sys-apps/haveged
		 sys-cluster/rbd-client-tools-noceph
		 sys-kernel/dracut
		 sys-process/procps"

src_install() {
	cp -a ${WORKDIR}/* ${D}/
}
