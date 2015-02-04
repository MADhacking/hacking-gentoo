# Copyright 2012 Hacking Networked Solutions
# Distributed under the terms of the GNU General Public License v3
# Based on a previous version found at http://code.google.com/p/rion-overlay/
# $Header: $

EAPI="4"

inherit libtool autotools  autotools-utils

DESCRIPTION="Provides an easy-to-use PKI library and tools for PKI enabled application development."
HOMEPAGE="http://www.openca.org/projects/libpki"
SRC_URI="mirror://sourceforge/project/openca/${PN}/releases/v${PV}/sources/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="examples mysql postgres ssl static-libs ldap"

DEPEND="dev-libs/libxml2
	dev-libs/openssl
	ldap? ( net-nds/openldap )
	mysql? ( virtual/mysql  )
	postgres? ( dev-db/postgresql )"
RDEPEND="${DEPEND}"

DOCS=(AUTHORS ChangeLog INSTALL NEWS README)

RESTRICT="test"
AUTOTOOLS_IN_SOURCE_BUILD=1

src_prepare() {
	epatch "${FILESDIR}"/makefile.patch

	autotools-utils_src_prepare
	AT_NOELIBTOOLIZE=yes eautoreconf
}

src_configure () {
	local myeconfargs=(
		$(use_enable ldap) \
		--with-package-prefix="${EPREFIX}" \
		$(use_enable mysql) \
		$(use_enable postgres pg) \
		--disable-kmf \
		--enable-ecdsa \
		$(use_enable ssl openssl-engine) \
		--disable-iphone)
	autotools-utils_src_configure
}

src_install() {
	autotools-utils_src_install

	if use examples; then
		insinto /usr/share/doc/"${PF}"
		doins -r examples
	fi
}

pkg_postinst() {
	einfo "Information describing the configuration of LibPKI may be found at"
	einfo "http://wiki.openca.org/wiki/index.php/LibPKI_configuration_files"
}
