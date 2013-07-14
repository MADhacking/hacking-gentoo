# Copyright 2013 Hacking Networked Solutions
# Distributed under the terms of the GNU General Public License v3
# $Header: $

EAPI="4"

USE_RUBY="ree18 ruby18 ruby19"

inherit ruby-ng

DESCRIPTION="Framework to implement server orchestration or parallel job execution systems"
HOMEPAGE="http://marionette-collective.org/"
SRC_URI="http://puppetlabs.com/downloads/mcollective/mcollective-${PV}.tgz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND=""
RDEPEND=""

src_compile() {
	einfo "nothing to compile"
}

each_ruby_install() {
	doruby -r lib/*

	if use doc ; then
		dohtml -r doc/*
	fi
}
