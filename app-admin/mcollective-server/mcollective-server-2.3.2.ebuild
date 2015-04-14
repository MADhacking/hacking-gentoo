# Copyright 2013 Hacking Networked Solutions
# Distributed under the terms of the GNU General Public License v3
# $Header: $

EAPI="4"

USE_RUBY="ruby18 ree18 ruby19"

inherit systemd ruby-ng

DESCRIPTION="Framework to build server orchestration or parallel job execution systems"
HOMEPAGE="http://marionette-collective.org/"
SRC_URI="http://downloads.puppetlabs.com/mcollective/mcollective-${PV}.tgz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="dev-libs/mcollective"

src_compile() {
	einfo "nothing to compile"
}

all_ruby_install() {
	dosbin mcollective-${PV}/bin/mcollectived
	newinitd "${FILESDIR}"/mcollectived.initd mcollectived
	systemd_newunit "${FILESDIR}/mcollectived.service" "mcollectived.service"
	
	insinto /etc/mcollective
	doins ${FILESDIR}/server.cfg
	doins ${FILESDIR}/facts.yaml
	doins mcollective-${PV}/etc/*.erb
}

pkg_postinst() {
	einfo "MCollective requires a functional message queue server be available on"
	einfo "your local network before you can use it. The recommended server to use"
	einfo "on Gentoo is RabbitMQ."
	einfo
	einfo "It is recommended you read the 'getting started' guide [2] if this"
	einfo "is a new installation"
	einfo
	einfo "[1] http://www.rabbitmq.com/"
	einfo "[2] http://docs.puppetlabs.com/mcollective/deploy/standard.html"
}
