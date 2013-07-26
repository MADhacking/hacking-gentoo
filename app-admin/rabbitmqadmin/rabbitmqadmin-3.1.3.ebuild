# Copyright 2013 Hacking Networked Solutions
# Distributed under the terms of the GNU General Public License v3+
# $Header: $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit python-single-r1

DESCRIPTION="Command line administration tool for RabbitMQ"
HOMEPAGE="http://www.rabbitmq.com/management-cli.html"
SRC_URI="http://downloads.mad-hacking.net/software/${P}.tar.bz2"

SLOT="0"
LICENSE="MPL-1.1"
KEYWORDS="~amd64 ~x86"

RDEPEND="${PYTHON_DEPS}"
DEPEND="${RDEPEND}"

src_install() {
	python_export python2_7 EPYTHON

	python_scriptinto /usr/sbin
	python_doscript usr/bin/rabbitmqadmin
}
                  