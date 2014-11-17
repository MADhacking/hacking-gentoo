# Copyright 2014 Hacking Networked Solutions
# Distributed under the terms of the GNU General Public License v2+
# $Header: $

EAPI="3"

DESCRIPTION="An XML DTD for XSLT"
HOMEPAGE="http://www.w3.org/TR/xslt"
SRC_URI="http://www.w3.org/1999/11/xslt10.dtd"

LICENSE="W3C"
SLOT="1.0"
KEYWORDS="alpha amd64 arm arm64 hppa ia64 m68k mips ppc ppc64 s390 sh sparc sparc-fbsd x86 x86-fbsd"
IUSE=""

src_unpack() {
	einfo "No unpack required."
}

src_install() {
	insinto /usr/share/xml/xslt
	doins "${PORTAGE_TMPDIR}/portage/${CATEGORY}/${PF}/distdir/xslt10.dtd"
}
