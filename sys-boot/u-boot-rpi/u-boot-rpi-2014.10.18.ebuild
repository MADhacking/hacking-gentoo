# Copyright 2014 Hacking Networked Solutions
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit eutils mount-boot

DESCRIPTION=""
HOMEPAGE=""
SRC_URI="http://downloads.mad-hacking.net/software/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="~arm"

DEPEND=""
RDEPEND="${DEPEND}"

src_configure() {
	emake rpi_b_defconfig
}

src_compile() {
	emake
}

src_install() {
	insinto /usr/share/uboot
	
	doins u-boot.bin u-boot.map u-boot.srec
}

setup_boot_dir() {
	local boot_dir=$1
	local dir=${boot_dir}

	mkdir -p "${dir}"
	[[ ! -L ${dir}/boot ]] && ln -s . "${dir}/boot"
	dir="${dir}/grub"
	if [[ ! -e ${dir} ]] ; then
		mkdir "${dir}" || die
	fi
	
	for x in "${ROOT}"/usr/share/uboot/* ; do
		[[ -f ${x} ]] && cp -p "${x}" "${dir}"/
	done
}

pkg_postinst() {
	mount-boot_mount_boot_partition

	if [[ -n ${DONT_MOUNT_BOOT} ]]; then
		elog "WARNING: you have DONT_MOUNT_BOOT in effect, so you must apply"
		elog "the following instructions for your /boot!"
		elog "Neglecting to do so may cause your system to fail to boot!"
		elog
	else
		setup_boot_dir "${ROOT}"/boot
		# Trailing output because if this is run from pkg_postinst, it gets mixed into
		# the other output.
		einfo ""
	fi
	elog "To interactively install u-boot files to another device such as a USB"
	elog "stick, just run the following and specify the directory as prompted:"
	elog "   emerge --config =${PF}"
	elog "Alternately, you can export UBOOT_ALT_INSTALLDIR=/path/to/use to tell"
	elog "u-boot where to install in a non-interactive way."

	# needs to be after we call setup_boot_dir
	mount-boot_pkg_postinst
}

pkg_config() {
	local dir
	if [ ! -d "${UBOOT_ALT_INSTALLDIR}" ]; then
		einfo "Enter the directory where you want to setup u-boot:"
		read dir
	else
		dir="${UBOOT_ALT_INSTALLDIR}"
	fi
	setup_boot_dir "${dir}"
}
