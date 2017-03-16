# Copyright 2017 Hacking Networked Solutions
# Distributed under the terms of the GNU General Public License v3
# $Header: $

EAPI="6"

PYTHON_COMPAT=( python2_7 )

inherit python-single-r1

RDEPEND="${PYTHON_DEPS}"
DEPEND="${RDEPEND}"

DESCRIPTION="Google Cloud SDK"
SLOT="0"
SRC_URI="https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/${P}-linux-x86_64.tar.gz"

LICENSE="https://cloud.google.com/terms/"
SLOT="0"
KEYWORDS="~amd64"
S="${WORKDIR}/google-cloud-sdk"

src_unpack() {
	if [ "${A}" != "" ]; then
		unpack ${A}
	fi
}

src_install() {
	cd "${WORKDIR}/${PN}"
	CLOUDSDK_PYTHON="/usr/bin/python2.7" ./install.sh --disable-prompts --install-dir=${D} || die
	python_optimize "${D}"usr/share/${PN}
}
