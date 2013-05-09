# Copyright 2012 Hacking Networked Solutions
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit autotools autotools-utils eutils

DESCRIPTION="OpenRC plugin providing event based hooks"
HOMEPAGE="http://www.mad-hacking.net/"
SRC_URI="http://downloads.mad-hacking.net/software/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86"

DEPEND=">=sys-apps/openrc-0.11.8"
RDEPEND="${DEPEND}"

src_prepare() {
	autotools-utils_src_prepare
	eautoreconf
}

src_configure() {
	autotools-utils_src_configure
}

src_install() {
	autotools-utils_src_install
	rm "${D}"/lib/rc/plugins/*.la
	dodir /lib/rc.hooks
}
