# Copyright 2015 MAD Hacking
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit eutils

DESCRIPTION="The most popular PHP library for Twitter's OAuth REST API"
HOMEPAGE="https://github.com/abraham/twitteroauth"
SRC_URI="https://github.com/abraham/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ~mips ppc ppc64 ~s390 ~sh ~sparc x86 ~amd64-fbsd amd64 x86"
IUSE=""

RDEPEND=">=dev-lang/php-5.4"
DEPEND="${REDPEND}"

src_install() {
	insinto /usr/share/php/${PN}
	doins -r "${S}/src/"*

	dodoc "${S}"/{LICENSE.md,README.md}
}