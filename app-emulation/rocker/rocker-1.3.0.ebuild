# Copyright 2017 Hacking Networked Solutions
# Distributed under the terms of the GNU General Public License v2

EAPI=6
EGO_PN="github.com/grammarly/${PN}"

inherit toolchain-funcs

if [[ ${PV} == *9999 ]]; then
	inherit golang-vcs
else
	MY_PV="${PV/_/-}"
	EGIT_COMMIT="${MY_PV}"
	SRC_URI="https://${EGO_PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="amd64 ~ppc64"
	inherit golang-vcs-snapshot
fi

DESCRIPTION="Rocker breaks the limits of Dockerfile by adding some crucial features"
HOMEPAGE="https://github.com/grammarly/rocker"

LICENSE="Apache-2.0"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND=""

S=${WORKDIR}/${P}/src/${EGO_PN}

src_compile() {
#	local options=( $(usex seccomp "seccomp") )
	export GOPATH="${WORKDIR}/${P}" # ${PWD}/vendor
#	LDFLAGS=$(usex hardened '-extldflags -fno-PIC' '')
	emake GIT_COMMIT="$EGIT_COMMIT" BUILDTAGS="${options[@]}"
}

src_install() {
	default_src_install
	dobin ${WORKDIR}/${P}/bin/rocker
}
