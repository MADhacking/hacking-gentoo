# Copyright 2012 Hacking Networked Solutions
# Distributed under the terms of the GNU General Public License v3

EAPI="3"

DESCRIPTION="Hacking Networked Solutions Certificates meta-package"
HOMEPAGE="http://ca.hacking.co.uk/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~ppc-aix ~amd64-fbsd ~sparc-fbsd ~x86-fbsd ~x64-freebsd ~x86-freebsd ~hppa-hpux ~ia64-hpux ~x86-interix ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris ~x86-winnt"
IUSE=""
RDEPEND="${DEPEND}
	app-misc/hacking-certificates-root
	app-misc/hacking-certificates-tier-one
	app-misc/hacking-certificates-tier-two"