# Copyright (c) 2012 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI="4"

inherit eutils

# This is a snapshot of "dev" branch
VER="dev-${PV}"
SRC_URI="https://storage.cloud.google.com/chromeos-localmirror/distfiles/flashbench-${VER}.tar.gz"
S=${WORKDIR}/${PN}-${VER}

DESCRIPTION="Flash Storage Benchmark"
HOMEPAGE="https://github.com/bradfa/flashbench"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_prepare() {
	epatch "${FILESDIR}"/flashbench-20121121-Makefile-install.patch
}

src_configure() {
	tc-export CC
}
