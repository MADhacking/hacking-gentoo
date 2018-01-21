# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/r8168/r8168-8.035.00-r1.ebuild,v 1.1 2013/03/06 21:37:48 joker Exp $

EAPI=4

inherit linux-mod eutils

DESCRIPTION="r8101 driver for Realtek 8101E/8102E PCI-E NICs"
HOMEPAGE="http://www.realtek.com.tw"
SRC_URI="http://12244.wpc.azureedge.net/8012244/drivers/rtdrivers/cn/nic/0008-r8101-${PV}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

KEYWORDS="~amd64 ~x86"

MODULE_NAMES="r8101(net:${S}/src)"
BUILD_TARGETS="modules"

ERROR_R8169="${P} requires Realtek 8169 PCI Gigabit Ethernet adapter (CONFIG_R8169) to be DISABLED or configured as a MODULE"

pkg_pretend() {
	linux_config_exists || die "You do not appear to have configured your kernel!"
	linux_chkconfig_builtin "R8169" && die "${ERROR_R8169}"
}

pkg_setup() {
	linux-mod_pkg_setup
	BUILD_PARAMS="KERNELDIR=${KV_DIR}"
}

src_install() {
	linux-mod_src_install
	mv readme README
	dodoc README

	insinto /etc/modprobe.d/
	doins "${FILESDIR}/r8101.conf"
}
