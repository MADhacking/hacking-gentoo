# Copyright 2012 Hacking Networked Solutions
# Distributed under the terms of the GNU General Public License v3
# $Header: $

EAPI="3"

DESCRIPTION="Hacking Networked Solutions base server meta-package"
HOMEPAGE="http://www.hacking.co.uk/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="+buildserver-client -hacking-certificates +ipsec +mcollective +puppet +rsync-backup-client +snmp"

# Package dependencies
#
RDEPEND="${DEPEND}
	app-admin/logrotate
	app-admin/sudo
	app-admin/syslog-ng
	app-editors/nano
	app-portage/eix
	app-portage/gentoolkit
	app-portage/portage-utils
	app-shells/bash-completion
	app-shells/gentoo-bashcomp
	net-analyzer/traceroute
	net-misc/ntp
	sys-apps/less
	sys-apps/timer_entropyd
	sys-fs/e2fsprogs
	sys-process/lsof
	sys-process/vixie-cron
	virtual/mailx"

# Configuration dependencies
RDEPEND="${RDEPEND}
	buildserver-client?   (	app-admin/buildserver-client-scripts
							net-fs/autofs
							net-fs/nfs-utils )
	hacking-certificates? ( app-misc/hacking-certificates )
	ipsec?				  ( net-firewall/ipsec-tools )
	mcollective?		  (	mcollective-plugin/mcollective-plugin-update-system
							app-admin/mcollective-server )
	puppet?				  (	app-admin/puppet )
	rsync-backup-client?  (	install-conf/rsync-backup-client )
	snmp?				  ( net-analyzer/net-snmp )"
