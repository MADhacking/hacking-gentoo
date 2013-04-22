# Copyright 2012 Hacking Networked Solutions
# Distributed under the terms of the GNU General Public License v3
# $Header: $

EAPI="3"

DESCRIPTION="Hacking Networked Solutions file server meta-package"
HOMEPAGE="http://www.hacking.co.uk/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
RDEPEND="${DEPEND}
	install-meta/hacking-base-server
	net-analyzer/tcpdump
	net-dialup/ppp
	net-dns/ddclient
	net-firewall/ipsec-tools
	net-firewall/iptables
	net-misc/dhcpcd
	sys-apps/ethtool
	sys-apps/iproute2"