# Copyright 2012 Hacking Networked Solutions
# Distributed under the terms of the GNU General Public License v3

EAPI="4"

inherit eutils

DESCRIPTION="Hacking Networked Solutions backup-client authentication configuration package"
HOMEPAGE="http://www.hacking.co.uk/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

# Package dependencies
#
RDEPEND="${DEPEND}
	app-admin/sudo
	app-shells/bash
	net-misc/openssh"

pkg_preinst() {
	# Create the backup user
	enewuser backup 900 /bin/bash /home/backup nogroup
}

src_unpack() {
	# We have no sources to unpack so create an empty ${S} directory
	mkdir -p "${S}"
}

src_install() {
	# Create and install ~/.ssh/authorized_keys
	insinto /home/backup/.ssh
	doins "${FILESDIR}/authorized_keys"

	# Copy ~/validate-backup-cmd.sh script
	exeinto /home/backup
	doexe "${FILESDIR}/validate-backup-cmd.sh"
}
