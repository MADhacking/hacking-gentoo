# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit apache-module 
DESCRIPTION="An XSLT page filter module for apache2"
# V1.5.3 not on sourceforge, but on author's site 
#SRC_URI="mirror://sourceforge/xslt-filter/${P}.tar.gz"
#SRC_URI="http://xslt-filter.deviurg.com/sources/${P}.tar.gz"
SRC_URI="http://xslt-filter.deviurg.com/sources/${P}.tar.gz"
HOMEPAGE="http://xslt-filter.deviurg.com/"

LICENSE="Apache-2.0"
KEYWORDS="~alpha ~amd64 ~ia64 ~mips ~ppc ~sparc ~x86"
IUSE=""
SLOT="0"

DEPEND=">=dev-libs/libxml2-2.6.30
	>=dev-libs/libxslt-1.1.20"
RDEPEND="${DEPENDS}"

# See apache-module.eclass for more information.
APACHE2_MOD_CONF="52_${PN}"
APACHE2_MOD_DEFINE="XSLT_FILTER"

DOCFILES="README"

need_apache2


src_unpack() {
	unpack ${A}
	cd "${S}"
}

src_compile() {
	econf --with-apxs=${APXS} || die "econf failed"
	emake OPT="`apxs2 -q CFLAGS` -fPIC" || die "econf failed"
}

src_install() {
	apache-module_src_install
}
