# Copyright 2012 Hacking Networked Solutions
# Distributed under the terms of the GNU General Public License v3
# $Header$

EAPI="3"

inherit webapp eutils depend.php confutils

DESCRIPTION="Poweradmin is a friendly web-based DNS administration tool for the PowerDNS server"
HOMEPAGE="http://www.poweradmin.org/"
SRC_URI="http://github.com/downloads/poweradmin/poweradmin/${P}.tgz"

LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"
IUSE="mysql postgres vhosts"

RDEPEND="mysql? ( || ( dev-php/PEAR-MDB2[mysql] dev-php/PEAR-MDB2[mysqli] ) )
	postgres? ( dev-php/PEAR-MDB2[postgres] )
	dev-lang/php[session]"

S="${WORKDIR}/${PN}.tmp"

need_httpd_cgi
need_php_httpd

pkg_setup() {
 	webapp_pkg_setup
 	confutils_require_any mysql postgres
}

src_install() {
	webapp_src_preinst

	cd "${P}"

	rm -f README.markdown LICENSE .gitignore

	insinto "${MY_HTDOCSDIR}"
	doins -r .

	webapp_postinst_txt en "${FILESDIR}/postinstall-en.txt"
	webapp_src_install
}

pkg_postinst() {
	webapp_pkg_postinst
}
