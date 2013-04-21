# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit eutils

DESCRIPTION="GeSHi the Generic Syntax Highlighter converts code to HTML and supports a range of popular languages"
HOMEPAGE="http://qbnz.com/highlighter/"
SRC_URI="mirror://sourceforge/geshi/geshi/GeSHi%20${PV}/GeSHi-${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ~mips ppc ppc64 ~s390 ~sh ~sparc x86 ~amd64-fbsd amd64 x86"
IUSE=""

RDEPEND=">=dev-lang/php-5.2"
DEPEND="${REDPEND}"

# This distributed archive has all contents in /geshi/
S=${WORKDIR}/${PN}

src_install() {

	# We want to install the geshi subdirectory and the geshi.php file
	# to /usr/share/php/geshi
	insinto /usr/share/php/${PN}
	doins -r ${S}/${PN}
	doins ${S}/${PN}.php

	dodoc ${S}/docs/{BUGS,CHANGES,README,THANKS,*.txt}
	dohtml ${S}/docs/*.html
}
