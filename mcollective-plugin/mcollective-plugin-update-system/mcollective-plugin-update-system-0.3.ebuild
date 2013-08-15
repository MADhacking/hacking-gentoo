# Copyright 2013 Hacking Networked Solutions
# Distributed under the terms of the GNU General Public License v3
# $Header: $

EAPI="3"

DESCRIPTION="An MCollective plug-in to automatically updated packages from a \"build-server\""
HOMEPAGE="http://www.mad-hacking.net/software/linux/gentoo/buildspace-scripts/index.xml"
SRC_URI="http://downloads.mad-hacking.net/software/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_install() {
	insinto /usr/share/mcollective/plugins/mcollective/agent
	doins usr/share/mcollective/plugins/mcollective/agent/*
	
	dosbin usr/sbin/*
}
