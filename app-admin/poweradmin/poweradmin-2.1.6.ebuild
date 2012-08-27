# Copyright 2012 Hacking Networked Solutions
# Distributed under the terms of the GNU General Public License v3
# $Header$

EAPI="3"

inherit webapp eutils depend.php confutils

DESCRIPTION="Poweradmin is a friendly web-based DNS administration tool for the PowerDNS server"
HOMEPAGE="http://www.poweradmin.org/"
SRC_URI="http://github.com/downloads/poweradmin/poweradmin/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="virtual/php
	www-servers/apache"

pkg_setup() {
 	webapp_pkg_setup
 	confutils_require_any mysql postgres
}

src_install() {
	webapp_src_preinst

	rm -f README.markdown LICENSE .gitignore

	insinto "${MY_HTDOCSDIR}"
	doins -r .

	webapp_postinst_txt en "${FILESDIR}/postinstall-en.txt"
	webapp_src_install
}

pkg_postinst() {
	webapp_pkg_postinst
}
