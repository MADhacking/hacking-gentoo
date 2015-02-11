# Copyright 2015 MAD Hacking
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit eutils

DESCRIPTION="The Facebook SDK for PHP provides a native interface to the Graph API and Facebook Login. "
HOMEPAGE="https://developers.facebook.com/docs/php"

LICENSE="Facebook"
SLOT="4"
KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ~mips ppc ppc64 ~s390 ~sh ~sparc x86 ~amd64-fbsd amd64 x86"
IUSE=""

SRC_URI="https://github.com/facebook/facebook-php-sdk-v${SLOT}/archive/${PV}.tar.gz -> ${P}.tar.gz"

RDEPEND=">=dev-lang/php-5.4"
DEPEND="${REDPEND}"

S="${WORKDIR}/${PN}-v${SLOT}-${PV}"

src_install() {
	insinto /usr/share/php/${PN}-v${SLOT}
	doins -r "${S}/src/Facebook/"*

	dodoc "${S}"/{CONTRIBUTING.md,LICENSE,README.md}
}
