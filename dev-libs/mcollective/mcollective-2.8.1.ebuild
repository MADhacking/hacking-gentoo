# Copyright 2013 Hacking Networked Solutions
# Distributed under the terms of the GNU General Public License v3
# $Header: $

EAPI="4"

USE_RUBY="ruby19 ruby20 ruby21 ruby22 ruby23"

inherit ruby-ng

DESCRIPTION="Framework to implement server orchestration or parallel job execution systems"
HOMEPAGE="https://docs.puppet.com/mcollective/"
SRC_URI="https://github.com/puppetlabs/marionette-collective/archive/${PV}.tar.gz -> mcollective-${PV}.tar.gz"
S="${WORKDIR}/all/mcollective-${PV}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND=""
RDEPEND=""

RDEPEND=">=dev-ruby/stomp-1.4.4"

src_compile() {
	einfo "nothing to compile"
}

each_ruby_install() {
	doruby -r lib/*
}

all_ruby_install() {
	insinto /usr/share/mcollective
	#doins -r plugins
	
	if use doc ; then
		dohtml -r doc/*
	fi
}
