# Copyright 2019 Hacking Networked Solutions
# Distributed under the terms of the GNU General Public License v3
# $Header: $

EAPI="3"

DESCRIPTION="Hacking Networked Solutions Web server meta-package"
HOMEPAGE="http://www.hacking.co.uk/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
RDEPEND="${DEPEND}
	install-meta/hacking-base-server
	dev-lang/php
	www-apache/mod_depends
	www-apache/mod_transform
	www-servers/apache"