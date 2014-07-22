# Copyright (c) 2014 Max Hacking - Hacking Networked Solutions
# Distributed under the terms of the GNU General Public License, v3 or later
# Author: Max Hacking <max.hacking@mad-hacking.net>

EAPI="5"

inherit eutils rebar

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
	S="${WORKDIR}/cl-cl-${PV}"
}

src_prepare() {
	sed -i -e 's/{vsn, git}/{vsn, "'${PV}'"}/' \
		${S}/src/cl.app.src || die "Sed failed!"
		
	find "${S}" -name .gitignore -delete
}

src_install() {
	rm -rf Makefile
	rm -rf c_src/*.o
	rm -rf examples
	rm -rf rebar.*
	
	dodoc README COPYRIGHT doc/*
	rm -rf README COPYRIGHT doc

	insinto "/usr/$(get_libdir)/erlang/lib/cl"
	doins -r *
}
