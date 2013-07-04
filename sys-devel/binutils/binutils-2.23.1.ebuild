# Copyright 2013 Hacking Networked Solutions
# Distributed under the terms of the GNU General Public License v3+
# $Header: $

PATCHVER="1.0"
ELF2FLT_VER=""
inherit toolchain-binutils

KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc x86 -amd64-fbsd -sparc-fbsd -x86-fbsd"

src_unpack() {
	tc-binutils_unpack
	cp "${FILESDIR}/97_all_binutils-scriptsdir.patch" ${EPATCH_SOURCE}
	tc-binutils_apply_patches
}
