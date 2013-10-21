# Copyright 2013 Hacking Networked Solutions
# Distributed under the terms of the GNU General Public License v3
# $Header: $

EAPI="3"

DESCRIPTION="A collection of scripts to automate backups with rsnapshot"
HOMEPAGE="http://www.mad-hacking.net/documentation/linux/reliability/backup/index.xml"
SRC_URI="http://downloads.mad-hacking.net/software/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="alpha amd64 ppc ppc64 sparc x86"
IUSE=""

RDEPEND="app-backup/rdiff-backup"

src_install() {
	exeinto /usr/sbin
	doexe usr/bin/*

	insinto /etc
	doins etc/*
}
