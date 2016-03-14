# Copyright 2012 Hacking Networked Solutions
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit apache-module autotools autotools-utils eutils

DESCRIPTION="Apache 2 module to block/hide resources from normal requests allowing access only from sub-requests"
HOMEPAGE="http://www.mad-hacking.net/software/linux/agnostic/apache/mod_authnz_subrequest/index.xml"
SRC_URI="http://downloads.mad-hacking.net/software/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND=">=www-apache/libapreq2-2.07"

RDEPEND="${DEPEND}"

APACHE2_MOD_CONF="0.1/08_${PN}"
APACHE2_MOD_DEFINE="AUTH_SUBREQUEST"

need_apache2

src_prepare() {
	autotools-utils_src_prepare
	eautoreconf
}

src_configure() {
	autotools-utils_src_configure
}

src_install() {
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
