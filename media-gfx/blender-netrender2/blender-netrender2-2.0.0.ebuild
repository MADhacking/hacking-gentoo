# Copyright 2013 Hacking Networked Solutions
# Distributed under the terms of the GNU General Public License v3

EAPI="3"

DESCRIPTION="Blender network rendering service (master)"
HOMEPAGE="http://www.hacking.co.uk/"
SRC_URI="http://downloads.mad-hacking.net/software/netrender2-${PV}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND=""
RDEPEND="${DEPEND}
		media-gfx/blender"

src_install() {
	doins -r ${WORKDIR}/netrender2-${PV}/*
}
