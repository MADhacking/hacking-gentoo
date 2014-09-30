# Copyright 2014 MAD Hacking
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

WX_GTK_VER="2.8"

inherit eutils wxwidgets

DESCRIPTION="USBDM interface for Freescale RS08, HCS08, HCS12, Coldfire & ARM-Kinetis devices"
HOMEPAGE="http://usbdm.sourceforge.net/"
SRC_URI="http://downloads.mad-hacking.net/software/${P}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="app-arch/unzip
		dev-libs/xerces-c
		virtual/libusb
		x11-libs/wxGTK:${WX_GTK_VER}[X]"

S="${WORKDIR}/usbdm-eclipse-makefiles-build-master"

QA_WX_LOAD="usr/share/usbdm/Stationery/ARM/cmsis/LIB/ARM/*.lib"
QA_PRESTRIPPED="usr/bin/* usr/$(get_libdir)/*.so.* usr/share/usbdm/FlashImages/MKxx/BootLoopK*.elf"

BD="${S}/PackageFiles"

src_prepare() {
	epatch "${FILESDIR}"/unix_file_handles.patch

	# Fix the location of the JDK in common makefile.
	JDK="$(java-config --jdk-home)"
	sed -i "s,-I/usr/lib/jvm/default-java/include,-I${JDK}/include -I${JDK}/include/linux,g" "${S}"/Common.mk || \
		die "Unable to fix JDK path!"
		
	# Fix the .desktop files.
	sed -i "/^Name\[en_AU\].*/D" "${BD}"/MiscellaneousLinux/*.desktop || die "Unable to fix .desktop files!"
	sed -i "/^Comment\[en_AU\].*/D" "${BD}"/MiscellaneousLinux/*.desktop || die "Unable to fix .desktop files!"
	sed -i "s,GenericName\[en_AU\],GenericName,g" "${BD}"/MiscellaneousLinux/*.desktop || die "Unable to fix .desktop files!"
}

src_compile() {
	# No parallel make:
	make -j1 DESTDIR="${D}" || die "Make failed!"
}

src_install() {
	# Work out the path to the files to install.
	use x86 && AS="i386-linux-gnu"
	use amd64 && AS="x86_64-linux-gnu"

	# Unless the debug USE flag has been set delete all the debug builds.
	use debug || find ${BD}/ -iname "*debug*" -delete

	# Fix the .desktop files
	# sed -i 's,\[en_AU\],,g' "${BD}"/MiscellaneousLinux/*.desktop || die "Unable to fix .desktop files"
	sed -i 's,Categories=Development,Categories=Electronics,g' "${BD}"/MiscellaneousLinux/*.desktop || die "Unable to fix .desktop files"
	
	# Install binaries and libraries
	dobin "${BD}"/bin/${AS}/*
	chmod +x "${BD}"/lib/${AS}/*
	dolib "${BD}"/lib/${AS}/*
	
	# Install UDEV rules
	insinto /lib/udev/rules.d/
	newins "${BD}"/MiscellaneousLinux/usbdm.rules 80-usbdm.rules
	
	# Install shared files
	cd "${BD}"
	#insinto /usr/share/usbdm/CDT_Plugins
	#doins -r CDT_Plugins/plugins 
	insinto /usr/share/usbdm/CW_Plugins
	doins -r CW_Plugins/*.jar
	insinto /usr/share/usbdm
	doins -r WizardPatches DeviceData Stationery Examples FlashImages LaunchConfig
	#insopts -m0755
	#doins Scripts/*.tcl
	doins MiscellaneousLinux/TryProgrammer

	# Install man pages
	cd "${S}"/Documentation/ManPages
	for MANPAGE in *; do
		mv ${MANPAGE} ${MANPAGE}.1
		doman ${MANPAGE}.1
	done

	# Install icon and desktop menu items
	doicon "${BD}"/MiscellaneousLinux/Hardware-Chip.png
	domenu "${BD}"/MiscellaneousLinux/*.desktop
}
