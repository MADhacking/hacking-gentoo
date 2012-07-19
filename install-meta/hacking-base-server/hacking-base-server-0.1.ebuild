# Copyright 2012 Hacking Networked Solutions
# Distributed under the terms of the GNU General Public License v3

EAPI="3"

DESCRIPTION="Hacking Networked Solutions base server meta-package"
HOMEPAGE="http://www.hacking.co.uk/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
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
	sys-process/vixie-cron
	virtual/mailx
	dev-libs/libgcrypt"