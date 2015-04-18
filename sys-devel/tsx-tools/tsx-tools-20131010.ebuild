# Copyright 2015 Hacking Networked Solutions
# Distributed under the terms of the GNU General Public License v2+
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="The Xen virtual machine monitor"
HOMEPAGE="http://xen.org/"
SRC_URI="https://github.com/andikleen/tsx-tools/archive/edc6bc1de73d116e96f89ec1425db75da3d4a98b.zip"
LICENSE="GPL-2"
SLOT="0"

DEPEND=""
RDEPEND=""
PDEPEND=""

RESTRICT="test"

S="${WORKDIR}/tsx-tools-edc6bc1de73d116e96f89ec1425db75da3d4a98b"

src_install()
{
	dobin has-tsx 
	dolib.so ignore-xend.so
	dodoc LICENSE README.md
	
	insinto /usr/include/tsx-tools
	doins include/*.h
}
