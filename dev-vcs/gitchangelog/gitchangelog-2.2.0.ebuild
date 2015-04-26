# Copyright 2015 Hacking Networked Solutions
# Distributed under the terms of the GNU General Public License v3
# $Header: $

EAPI="5"

PYTHON_COMPAT=( python{2_7,3_2,3_3} )

inherit distutils-r1

DESCRIPTION="Creates a changelog from git log history."
HOMEPAGE="https://github.com/vaab/gitchangelog"
SRC_URI="https://github.com/vaab/${PN}/archive/${PV}.tar.gz"
RELEASE_DATE="27 Jan 2015"

LICENSE="ValentinLab"
SLOT="0"
KEYWORDS="alpha amd64 arm arm64 hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~ppc-aix ~amd64-fbsd ~sparc-fbsd ~x86-fbsd ~x64-freebsd ~x86-freebsd ~ia64-hpux ~x86-interix ~amd64-linux ~arm-linux ~ia64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"IUSE=""

DEPEND="dev-python/d2to1
		dev-python/pystache"
RDEPEND="dev-vcs/git"

python_prepare_all() {
	echo "${PV}" > "${WORKDIR}"/version.txt
	echo "${RELEASE_DATE}" > "${WORKDIR}"/datestamp.txt
	
	local PATCHES=( "${FILESDIR}"/autogen-no-git.patch "${FILESDIR}"/install-locations.patch )
	
	distutils-r1_python_prepare_all
}

python_install_all() {
	distutils-r1_python_install_all
	
	mv "${D}"/usr/gitchangelog.rc.reference "${D}"/usr/share/doc/gitchangelog-${PV}/
}
