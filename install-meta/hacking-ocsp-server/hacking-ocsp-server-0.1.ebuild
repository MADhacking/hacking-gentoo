# Copyright 2012 Hacking Networked Solutions
# Distributed under the terms of the GNU General Public License v3
# $Header: $

EAPI="3"

DESCRIPTION="Hacking Networked Solutions OCSP server meta-package"
HOMEPAGE="http://www.hacking.co.uk/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RDEPEND="${DEPEND}
	install-meta/hacking-base-server
	app-misc/openca-ocspd
	sys-fs/inotify-tools
	www-servers/apache"