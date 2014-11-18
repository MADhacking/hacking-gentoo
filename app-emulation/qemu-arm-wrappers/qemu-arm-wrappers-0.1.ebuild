# Copyright 2013 Hacking Networked Solutions
# Distributed under the terms of the GNU General Public License v3
# $Header: $

EAPI="3"

DESCRIPTION="A collection of wrapper scripts to select the CPU type when using qemu-arm"
HOMEPAGE="http://www.mad-hacking.net/documentation/linux/deployment/buildserver/installation-build-qemu.xml"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~ppc ~ppc64 x86 ~x86-fbsd"
IUSE=""

DEPEND="app-emulation/qemu[qemu_user_targets_arm,static-user]"
RDEPEND="${DEPEND}"

src_prepare() {
	mkdir -p "${S}"/src
	for cpu in $(qemu-arm -cpu help | head -n -1 | tail -n +2); do
		sed "s/replace_this/${cpu}/" "${FILESDIR}"/qemu-wrapper.c > "${S}"/src/qemu-arm-${cpu}.c
	done
}

src_compile() {
	mkdir -p "${S}"/bin
	for cpu in $(qemu-arm -cpu help | head -n -1 | tail -n +2); do
		gcc -static "${S}"/src/qemu-arm-${cpu}.c -O3 -o "${S}"/bin/qemu-arm-${cpu}
	done
}

src_install() {
	dobin "${S}"/bin/*
}
