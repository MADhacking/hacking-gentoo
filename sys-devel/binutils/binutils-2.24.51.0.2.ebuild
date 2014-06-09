# Copyright 2013 Hacking Networked Solutions
# Distributed under the terms of the GNU General Public License v3+
# $Header: $

PATCHVER="1.1"
ELF2FLT_VER=""
inherit toolchain-binutils

src_unpack() {
	tc-binutils_unpack
	cp "${FILESDIR}/97_all_binutils-scriptsdir.patch" ${EPATCH_SOURCE}
	tc-binutils_apply_patches
}
