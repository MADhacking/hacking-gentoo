# Copyright 2013 Hacking Networked Solutions
# Distributed under the terms of the GNU General Public License v3
# $Header: $

EAPI="3"

DESCRIPTION="Client tools for Rados Block Device (RBD) including mount.rbd helper script"
HOMEPAGE="http://www.mad-hacking.net/"
SRC_URI="http://downloads.mad-hacking.net/software/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="arm amd64 x86"
IUSE=""

RDEPEND=""

src_install() {
	cp -a ${WORKDIR}/* ${D}/
}
