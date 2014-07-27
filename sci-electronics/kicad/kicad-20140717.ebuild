# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/kicad/kicad-20130518.ebuild,v 1.1 2013/06/06 19:24:31 calchan Exp $

#TODO:
# - python and wxpython scripting
# - GIThub plugin

EAPI="5"

WX_GTK_VER="2.8"

inherit eutils unpacker cmake-utils wxwidgets fdo-mime gnome2-utils

DESCRIPTION="Electronic Schematic and PCB design tools."
HOMEPAGE="http://www.kicad-pcb.org"

RELEASE_DATE="20140717"
BZR_REV="5006"

SRC_URI="http://downloads.mad-hacking.net/software/${PN}-${RELEASE_DATE}+${BZR_REV}.tar.bz2"

LICENSE="GPL-2 kicad-doc"
SLOT="0"

KEYWORDS="~amd64 ~x86"

IUSE="debug doc"

CDEPEND="x11-libs/wxGTK:${WX_GTK_VER}[gnome,opengl,X]
	dev-python/wxpython:${WX_GTK_VER}[opengl]"
DEPEND="${CDEPEND}
	>=dev-util/cmake-2.6.4
	>=dev-libs/boost-1.55[context,python]
	app-doc/doxygen"
RDEPEND="${CDEPEND}
	sys-libs/zlib
	sci-electronics/electronics-menu
	sci-electronics/kicad-doc
	sci-electronics/kicad-library
	sci-electronics/kicad-fp-library"

S="${WORKDIR}/kicad-${RELEASE_DATE}+${BZR_REV}"

src_prepare() {
	epatch "${FILESDIR}/${PN}-scripts-${PV}.patch"
	epatch "${FILESDIR}/${PN}-missing-doc-${PV}.patch"
	
	sed -i -e 's/Categories=Development;Electronics/Categories=Electronics;/' \
		${S}/resources/linux/mime/applications/*.desktop || die "Sed failed!"
}

src_configure() {
	need-wxwidgets unicode

	mycmakeargs="${mycmakeargs}
		-DKICAD_SKIP_BOOST=ON
		-DKICAD_STABLE_VERSION=ON
		-DKICAD_wxUSE_UNICODE=ON
		-DKICAD_DOCS=/usr/share/doc/${PN}
		-DKICAD_HELP=/usr/share/doc/${PN}"

#		-DKICAD_SCRIPTING=ON
#		-DKICAD_SCRIPTING_MODULES=ON
#		-DKICAD_SCRIPTING_WXPYTHON=ON
#		-DBUILD_GITHUB_PLUGIN=ON

	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile all doxygen-docs
}

src_install() {
	cmake-utils_src_install

	if use doc ; then
		insinto "/usr/share/doc/${PN}/development"
		cd "${S}/Documentation"
		doins -r *
	fi
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update

	elog "You may want to emerge media-gfx/wings if you want to create 3D models of components."
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
}
