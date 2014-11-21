# Copyright 2014 Modaptix Ltd
# Distributed under the terms of the GNU General Public License v2

EAPI="5"

ETYPE="sources"
K_WANT_GENPATCHES="base extras experimental"
K_GENPATCHES_VER="9"
K_DEFCONFIG="bcm2835_defconfig"
K_SECURITY_UNSUPPORTED="1"

UNIPATCH_LIST=" ${FILESDIR}/rpi-bcm2835-master-2014-11-10/*.patch
				${FILESDIR}/fbtft-20141104.patch.bz2
				${FILESDIR}/fdt_loader.patch
				${FILESDIR}/bcm2708_pinctrl_driver.patch"
CKV="3.16.7"

inherit kernel-2
detect_version
detect_arch

KEYWORDS="~arm"
HOMEPAGE="https://github.com/notro"
IUSE="experimental"

DESCRIPTION="ARCH_BCM2835 (Raspberry Pi) Linux kernel sources with Notro patches"
SRC_URI="${KERNEL_URI} ${GENPATCHES_URI} ${ARCH_URI}"
