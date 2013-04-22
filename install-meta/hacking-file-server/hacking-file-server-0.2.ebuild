# Copyright 2012 Hacking Networked Solutions
# Distributed under the terms of the GNU General Public License v3
# $Header: $

EAPI="3"

DESCRIPTION="Hacking Networked Solutions file server meta-package"
HOMEPAGE="http://www.hacking.co.uk/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="+rdiff-backup-client"
RDEPEND="${DEPEND}
	install-meta/hacking-base-server
	net-fs/samba"

# Configuration dependencies
RDEPEND="${RDEPEND}
	rdiff-backup-client? ( install-conf/rdiff-backup-client )"
