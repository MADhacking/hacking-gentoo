# Copyright 2013 Hacking Networked Solutions
# Distributed under the terms of the GNU General Public License v3
# $Header: $

EAPI="4"

USE_RUBY="ree18 ruby18 ruby19"

inherit ruby-ng

DESCRIPTION="Framework to implement server orchestration or parallel job execution systems"
HOMEPAGE="http://marionette-collective.org/"
SRC_URI="http://downloads.puppetlabs.com/mcollective/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND=""
RDEPEND="dev-ruby/stomp"

src_compile() {
	einfo "nothing to compile"
}

each_ruby_install() {
	doruby -r lib/*
}

all_ruby_install() {
	insinto /usr/share/mcollective
	doins -r plugins
	
	if use doc ; then
		dohtml -r doc/*
	fi
}
