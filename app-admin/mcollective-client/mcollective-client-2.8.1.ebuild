# Copyright 2013 Hacking Networked Solutions
# Distributed under the terms of the GNU General Public License v3
# $Header: $

EAPI="4"

USE_RUBY="ruby19 ruby20 ruby21 ruby22"

inherit ruby-ng

DESCRIPTION="Framework to build server orchestration or parallel job execution systems"
HOMEPAGE="http://marionette-collective.org/"
SRC_URI="http://downloads.puppetlabs.com/mcollective/mcollective-${PV}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND=""

ruby_add_rdepend "dev-libs/mcollective"

src_compile() {
	einfo "nothing to compile"
}

all_ruby_install() {
	insinto /usr/bin
	dobin mcollective-${PV}/bin/mco
	#dobin mcollective-${PV}/bin/mc-*
		
	insinto /etc/mcollective
	doins ${FILESDIR}/client.cfg
	doins mcollective-${PV}/etc/*.erb
}

pkg_postinst() {
	einfo "MCollective requires a functional message queue server be available on"
	einfo "your local network before you can use it. The recommended message queue"
	einfo "server to use on Gentoo Linux is RabbitMQ."
	einfo
	einfo "It is recommended you read the \'getting started\' guide [2] if this"
	einfo "is a new installation"
	einfo
	einfo "[1] http://www.rabbitmq.com/"
	einfo "[2] http://docs.puppetlabs.com/mcollective/deploy/standard.html"
}
