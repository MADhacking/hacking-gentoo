# Copyright 2012 Hacking Networked Solutions
# Distributed under the terms of the GNU General Public License v3
# $Header: $

EAPI="4"

inherit eutils

DESCRIPTION="Hacking Networked Solutions rsnapshot-backup-client configuration package"
HOMEPAGE="http://www.hacking.co.uk/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="${DEPEND}
	app-admin/sudo
	app-backup/rdiff-backup
	app-shells/bash
	install-conf/backup-client-auth
	net-misc/openssh"

src_unpack() {
	# We have no sources to unpack so create an empty ${S} directory
	mkdir -p "${S}"
}

src_install() {
	insinto /etc/sudoers.d
	doins "${FILESDIR}/50_rdiff_backup_client"
	fperms 0440 "/etc/sudoers.d/50_rdiff_backup_client"
}
