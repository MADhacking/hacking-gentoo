# Copyright (c) 2014 Max Hacking - Hacking Networked Solutions
# Distributed under the terms of the GNU General Public License, v3 or later
# Author: Max Hacking <max.hacking@mad-hacking.net>

EAPI="5"

inherit rebar

DESCRIPTION="OpenCL binding for Erlang"
HOMEPAGE="https://github.com/tonyrog/cl"
SRC_URI="https://github.com/tonyrog/cl/archive/cl-${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="virtual/opencl"
DEPEND="${RDEPEND}"

pkg_setup() {
	ERLANG_PKG_INSTALL_DIR="cl-${PV}"
	ERLANG_PKG_LINK_DIR="cl"
	S="${WORKDIR}/cl-cl-${PV}"
}

src_prepare() {
	sed -i -e 's/{vsn, git}/{vsn, "'${PV}'"}/' \
		${S}/src/cl.app.src || die "Sed failed!"
}
