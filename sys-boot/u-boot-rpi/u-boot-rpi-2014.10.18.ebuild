# Copyright 2014 Hacking Networked Solutions
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit eutils

DESCRIPTION=""
HOMEPAGE=""
SRC_URI="http://downloads.mad-hacking.net/software/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="~arm"

DEPEND=""
RDEPEND="${DEPEND}"

src_configure() {
	emake rpi_b_defconfig
}

src_compile() {
	emake
}

src_install() {
	emake install
}
