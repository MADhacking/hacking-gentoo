# Copyright 2014 Modaptix Ltd.
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit mount-boot

DESCRIPTION="Raspberry PI boot loader and firmware"
HOMEPAGE="https://github.com/raspberrypi/firmware"
MY_COMMIT="1513cf89c1"
SRC_URI=""
for my_src_uri in bootcode.bin fixup{,_cd,_x}.dat start{,_cd,_x}.elf ; do
	SRC_URI="${SRC_URI} https://github.com/raspberrypi/firmware/raw/${MY_COMMIT}/boot/${my_src_uri} -> ${PN}-${MY_COMMIT}-${my_src_uri}"
done

LICENSE="GPL-2 raspberrypi-videocore-bin"
SLOT="0"
KEYWORDS="~arm"
IUSE=""

DEPEND=""
RDEPEND=""

S=${WORKDIR}

RESTRICT="binchecks strip"

src_unpack() {
	einfo "No unpack required"
}

src_install() {
	insinto /usr/share/${PN}
	local a
	for a in ${A} ; do
		newins "${DISTDIR}"/${a} ${a#${PN}-${MY_COMMIT}-}
	done
	newins "${FILESDIR}"/${PN}-0_p20130711-config.txt config.txt
	newins "${FILESDIR}"/${PN}-0_p20130711-cmdline.txt cmdline.txt
	newenvd "${FILESDIR}"/${PN}-0_p20130711-envd 90${PN}
}

setup_boot_dir() {
	local boot_dir=$1

	if [[ ! -e ${boot_dir} ]] ; then
		die "Unable to locate boot directory [${boot_dir}]"
	fi
	
	for x in "${ROOT}"/usr/share/${PN}/* ; do
		[[ -f ${x} ]] && cp -p "${x}" "${boot_dir}"/
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
	elog "To interactively install Raspberry Pi firmware files to another device such as a USB"
	elog "stick, just run the following and specify the directory as prompted:"
	elog "   emerge --config =${PF}"

	# needs to be after we call setup_boot_dir
	mount-boot_pkg_postinst
}

pkg_config() {
	setup_boot_dir "${ROOT}"/boot
}
