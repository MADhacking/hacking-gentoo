# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/kicad/kicad-20130518.ebuild,v 1.1 2013/06/06 19:24:31 calchan Exp $

EAPI="5"

inherit eutils unpacker cmake-utils 

DESCRIPTION="Electronic Schematic and PCB design tools."
HOMEPAGE="http://www.kicad-pcb.org"

RELEASE_DATE="20140717"
BZR_REV="5006"

SRC_URI="http://downloads.mad-hacking.net/software/${PN}-${RELEASE_DATE}+${BZR_REV}.tar.bz2"

LICENSE="GPL-2 kicad-doc"
SLOT="0"

KEYWORDS="~amd64 ~x86"

LANGS="bg ca cs de el_GR en es fi fr hu it ja ko nl pl pt ru sl sv zh_CN"
for lang in ${LANGS} ; do
	IUSE="${IUSE} linguas_${lang}"
done

DEPEND=">=dev-util/cmake-2.6.4"

RDEPEND="!<sci-electronics/kicad-20140717"

S="${WORKDIR}/kicad-doc-${RELEASE_DATE}+${BZR_REV}"

src_configure() {
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}

src_install() {
	insinto /usr/share/doc/${PN}
	doins -r "${S}/doc/contrib"
	
	insinto /usr/share/doc/kicad/help
	for lang in $LANGS ; do
		if [[ -d "${S}/doc/help/${lang}" ]] ; then
			use linguas_$lang && doins "${S}"/doc/help/${lang}/*.pdf
		fi
	done

	insinto /usr/share/doc/kicad/tutorials
	for lang in $LANGS ; do
		if [[ -d "${S}/doc/tutorials/${lang}" ]] ; then
			use linguas_$lang && doins "${S}"/doc/tutorials/${lang}/*.pdf
		fi
	done

	local dev_doc="/usr/share/doc/kicad/development"
	insinto ${dev_doc}
	doins GUI_Translation_HOWTO.pdf
	doins "${S}/doc/help/file_formats/file_formats.pdf"

	docompress -x \
		${dev_doc}/GUI_Translation_HOWTO.pdf \
		${dev_doc}/file_formats.pdf
}
