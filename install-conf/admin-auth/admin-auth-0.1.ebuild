# Copyright 2012 Hacking Networked Solutions
# Distributed under the terms of the GNU General Public License v3
# $Header: $

EAPI="4"

inherit eutils

DESCRIPTION="Hacking Networked Solutions backup-client authentication configuration package"
HOMEPAGE="http://www.hacking.co.uk/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

S="${WORKDIR}"

src_install() {
	# Create and install /root/.ssh/authorized_keys
	insinto /root/.ssh
	doins "${FILESDIR}/authorized_keys"
}
