# Copyright 2013 Hacking Networked Solutions
# Distributed under the terms of the GNU General Public License v3
# $Header: $

EAPI="3"

DESCRIPTION="A collection of scripts to automatically build updated packages inside a \"build-space\""
HOMEPAGE="http://www.mad-hacking.net/software/linux/gentoo/buildspace-scripts/index.xml"
SRC_URI="http://downloads.mad-hacking.net/software/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~arm64 ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~sparc-fbsd x86 ~x86-fbsd"
IUSE=""

RDEPEND="<app-portage/gentoolkit-0.3.1
		 app-portage/portage-utils
		 >=dev-libs/bash-outlogger-0.2
		 app-admin/buildserver-client-scripts"

src_install() {
	exeinto /usr/bin
	doexe bin/*

	insinto /etc
	doins etc/*
}
