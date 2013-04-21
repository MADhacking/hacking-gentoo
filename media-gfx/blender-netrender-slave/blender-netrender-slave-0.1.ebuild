# Copyright 2013 Hacking Networked Solutions

EAPI="3"

inherit user

DESCRIPTION="Blender network rendering service (slave)"
HOMEPAGE="http://www.hacking.co.uk/"
SRC_URI="http://downloads.mad-hacking.net/software/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
DEPEND=""
RDEPEND="${DEPEND}
		 media-gfx/blender
		 media-gfx/blender-netrender2"

spooldir="/var/spool/blender/slave"
logdir="/var/log/blender"

pkg_setup() {
	enewgroup blender 820
	enewuser blenders 821 -1 ${spooldir} blender
}

src_install() {
	doinitd ${WORKDIR}/${P}/etc/init.d/blender.slave

	insinto /usr
	doins -r ${WORKDIR}/${P}/usr/*

	dodir ${logdir}
	fowners root:blender ${logdir}
	fperms 0770 ${logdir}

	dodir ${spooldir}
	fowners blenders:blender ${spooldir}
	fperms 0750 ${spooldir}
}
