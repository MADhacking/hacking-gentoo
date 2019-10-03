# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A helper library providing common assertions for bats / bats-core"
HOMEPAGE="https://github.com/jasonkarns/bats-assert-1"
SRC_URI="https://github.com/jasonkarns/${PN}-1/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="CC0-1.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

#IUSE="test"

#RESTRICT="!test? ( test )"

RDEPEND="dev-util/bats-support"
#DEPEND="test? ( dev-util/bats-support )"

#src_test() {
#	/usr/bin/bats --tap test || die "Tests failed"
#}

S="${WORKDIR}/${PN}-1-${PV}"

src_install() {
	einstalldocs

	insinto /usr/lib/"${PN}"
	doins load.bash
	
	insinto /usr/lib/"${PN}"/src
	doins src/*
}
