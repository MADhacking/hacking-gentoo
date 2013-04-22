# Copyright 2012 Hacking Networked Solutions
# Distributed under the terms of the GNU General Public License v3
# $Header: $

EAPI="3"

DESCRIPTION="Hacking Networked Solutions base server meta-package"
HOMEPAGE="http://www.hacking.co.uk/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="+rsync-backup-client"

# Package dependencies
#
RDEPEND="${DEPEND}
	app-admin/sudo
	app-admin/syslog-ng
	app-editors/nano
	app-misc/hacking-certificates
	app-portage/eix
	app-portage/gentoolkit
	app-portage/portage-utils
	app-shells/bash-completion
	app-shells/gentoo-bashcomp
	net-analyzer/net-snmp
	net-firewall/ipsec-tools
	net-fs/autofs
	net-fs/nfs-utils
	net-misc/ntp
	sys-apps/less
	sys-apps/timer_entropyd
	sys-process/lsof
	sys-process/vixie-cron
	virtual/mailx"

# Configuration dependencies
RDEPEND="${RDEPEND}
	rsync-backup-client? ( install-conf/rsync-backup-client )"

# Forgotten dependencies
#
# 	dev-libs/libgcrypt	needed by net-fs/nfs-utils
#	dev-db/libdbi		needed by net-analyzer/rrdtool (dep of net-analyzer/net-snmp)
RDEPEND="${RDEPEND}
	dev-libs/libgcrypt
	dev-db/libdbi"