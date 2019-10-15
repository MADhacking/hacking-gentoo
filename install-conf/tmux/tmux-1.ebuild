# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=4

DESCRIPTION="Hacking Networked Solutions wide tmux configuration"
HOMEPAGE="https://www.hacking.co.uk/"

KEYWORDS="amd64 x86"
LICENSE="MIT"
SLOT="0"

RDEPEND="
    app-misc/tmux-sensible
    app-misc/tmux-mem-cpu-load
"

S="${WORKDIR}"

src_install() {
	insinto /etc
	doins "${FILESDIR}/tmux.conf"
	
	insinto /etc/tmux.d
	doins "${FILESDIR}/80-mem-cpu-load"
	doins "${FILESDIR}/98-local"
}
