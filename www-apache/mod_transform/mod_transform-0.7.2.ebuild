# Copyright 2012 Hacking Networked Solutions
# Distributed under the terms of the GNU General Public License v2

EAPI="4"

inherit apache-module autotools autotools-utils eutils

DESCRIPTION="Filter module that allows Apache2 to do dynamic XSL transformations."
HOMEPAGE="http://www.mad-hacking.net/software/linux/agnostic/apache/mod_transform/index.xml"
SRC_URI="http://downloads.mad-hacking.net/software/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="amd64 ~ppc x86"

DEPEND=">=dev-libs/libxslt-1.1.5
		>=dev-libs/libxml2-2.6.11
		>=www-apache/libapreq2-2.07
		>=www-apache/mod_depends-0.7.1"

RDEPEND="${DEPEND}"

APACHE2_MOD_CONF="0.7/10_${PN}"
APACHE2_MOD_DEFINE="TRANSFORM"

need_apache2_2

src_prepare() {
	autotools-utils_src_prepare
	eautoreconf
}

src_configure() {
	autotools-utils_src_configure
}

src_install() {
	# install header(s)
	local AP_INCLUDEDIR=$(${APXS} -q INCLUDEDIR)
	insinto ${AP_INCLUDEDIR}
	doins include/mod_transform.h || die

	if [[ -n "${APACHE2_MOD_CONF}" ]] ; then
	 	insinto "${APACHE_MODULES_CONFDIR}"
	 	set -- ${APACHE2_MOD_CONF}
		newins "${FILESDIR}/${1}.conf" "$(basename ${2:-$1}).conf" \
				|| die "internal ebuild error: '${FILESDIR}/${1}.conf' not found"
	fi

	autotools-utils_src_install
}

pkg_postinst() {
	apache-module_pkg_postinst
}
