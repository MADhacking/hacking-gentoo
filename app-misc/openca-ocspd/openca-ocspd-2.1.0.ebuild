# Copyright 2012 Hacking Networked Solutions
# Distributed under the terms of the GNU General Public License v3
# Based on a previous version found at http://code.google.com/p/slepnoga/

EAPI="4"

inherit autotools autotools-utils eutils

DESCRIPTION="An OCSP (Online Certificate Status Protocol) daemon"
HOMEPAGE="http://www.openca.org/projects/ocspd/"
SRC_URI="mirror://sourceforge/project/openca/${PN}/releases/v${PV}/sources/${P}.tar.gz"

LICENSE="OpenCA-OCSPD"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="debug"

DEPEND="dev-libs/libpki
		dev-libs/openssl"
RDEPEND="${DEPEND}"

DOCS=(AUTHORS ChangeLog INSTALL NEWS README)

RESTRICT="test"
AUTOTOOLS_IN_SOURCE_BUILD=1

src_prepare() {
	epatch "${FILESDIR}"/*.patch
	
	autotools-utils_src_prepare
	AT_NOELIBTOOLIZE=yes eautoreconf

	cd "${S}"/src/ocspd
	cp -f includes/*.h .
}

src_configure() {
	local myeconfargs=(
		--prefix=/
		--libdir=/usr/$(get_libdir)
		--sbindir=/usr/sbin
	)
	autotools-utils_src_configure
}

src_install() {
	autotools-utils_src_install
	
	newinitd "${FILESDIR}"/ocspd.rc ocspd
	
	insinto /etc/ocspd
	doins "${FILESDIR}"/ocspd.conf*
	
	enewuser ocspd
}
