# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/mcollective/mcollective-2.2.0.ebuild,v 1.3 2013/03/25 20:52:59 ago Exp $

EAPI="4"

USE_RUBY="ruby18 ree18 ruby19"

inherit ruby-ng

DESCRIPTION="Framework to build server orchestration or parallel job execution systems"
HOMEPAGE="http://marionette-collective.org/"
SRC_URI="http://puppetlabs.com/downloads/mcollective/mcollective-${PV}.tgz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="dev-libs/mcollective"

src_compile() {
	einfo "nothing to compile"
}

all_ruby_install() {
	insinto /usr/bin
	dobin mcollective-${PV}/bin/mco
}

pkg_postinst() {
	einfo "MCollective requires a functional message queue server be available on"
	einfo "your local network before you can use it. The recommended server to use"
	eingo "on Gentoo is RabbitMQ."
	einfo
	einfo "It is recommended you read the \'getting started\' guide [2] if this"
	einfo "is a new installation"
	einfo
	einfo "[1] http://www.rabbitmq.com/"
	einfo "[2] http://docs.puppetlabs.com/mcollective/deploy/standard.html"
}
