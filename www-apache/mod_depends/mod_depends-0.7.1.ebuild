# Copyright 2012 Hacking Networked Solutions
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit apache-module autotools autotools-utils eutils

DESCRIPTION="An apache helper module for handling dependencies properly."
SRC_URI="http://downloads.mad-hacking.net/software/${P}.tar.bz2"
HOMEPAGE="http://www.outoforder.cc/projects/apache/mod_depends/"

SLOT="0"
LICENSE="Apache-2.0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

APACHE2_MOD_CONF="0.7/09_${PN}"
APACHE2_MOD_DEFINE="DEPENDS"

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
	AP_INCLUDEDIR=$(${APXS} -q INCLUDEDIR)
	insinto ${AP_INCLUDEDIR}
	doins include/mod_depends.h || die

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
