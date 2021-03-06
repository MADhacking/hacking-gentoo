# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="A set of tmux options that should be acceptable to everyone"
HOMEPAGE="https://github.com/tmux-plugins/tmux-sensible"
SRC_URI="https://github.com/tmux-plugins/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

KEYWORDS="amd64 x86"
LICENSE="MIT"
SLOT="0"

RDEPEND="app-misc/tmux"

DOCS=( CHANGELOG.md LICENSE.md README.md )

PATCHES=(
	"${FILESDIR}/tmux-invalid-options.patch"
)

src_install() {
	einstalldocs

	exeinto /usr/lib/"${PN}"
	doexe *.tmux
	
	insinto /etc/tmux.d
	doins "${FILESDIR}/99-tmux-sensible"
}
