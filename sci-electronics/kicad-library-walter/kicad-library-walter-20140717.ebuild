# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/kicad/kicad-20130518.ebuild,v 1.1 2013/06/06 19:24:31 calchan Exp $

EAPI="5"

inherit eutils unpacker

DESCRIPTION="Electronic Schematic and PCB design tools."
HOMEPAGE="http://smisioto.no-ip.org/elettronica/kicad/kicad-en.htm"

SRC_URI="http://downloads.mad-hacking.net/software/${P}.tar.bz2"

LICENSE=""
SLOT="0"

KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="!<sci-electronics/kicad-20140717"

S="${WORKDIR}/kicad_libs"

src_prepare()
{
	mv "${S}/library/license.txt" "${S}/library-license.txt"
	mv "${S}/modules/license.txt" "${S}/modules-license.txt"

	mv "${S}/modules/packages3d/walter/release_notes.txt" "${S}/release_notes.txt"
	
	rm "${S}"/library/conn.* "${S}"/library/power.* "${S}"/library/*.zip
}

src_install() {
	insinto /usr/share/kicad
	
	doins -r "${S}/library" "${S}/modules"
	
	insinto "/usr/share/doc/${PN}"
	doins library-license.txt modules-license.txt release_notes.txt changelog.txt readme_git.txt
}
