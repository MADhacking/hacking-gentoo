# Copyright 2012 Hacking Networked Solutions
# Distributed under the terms of the GNU General Public License v3
# $Header$

EAPI="3"

DESCRIPTION="A simple Certificate Authority (CA) with support for extended X.509 features"
HOMEPAGE="http://www.mad-hacking.net/software/linux/agnostic/hacking-ca/index.xml"
SRC_URI="http://downloads.mad-hacking.net/software/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~sparc-fbsd ~x86-fbsd"
IUSE=""

RDEPEND="dev-libs/hacking-certificate-functions"

src_install() {
	insinto /usr/bin
	dobin usr/bin/*

	insinto /usr/share
	doins usr/share/*
}