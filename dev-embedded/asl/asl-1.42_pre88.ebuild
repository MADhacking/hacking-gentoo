# Copyright 2014 MAD Hacking
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit eutils

DESCRIPTION="A portable macro cross assembler for a variety of microprocessors and -controllers"
HOMEPAGE="http://john.ccac.rwth-aachen.de:8000/as/"
SRC_URI="http://downloads.mad-hacking.net/software/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-text/texlive"
RDEPEND=""

S="${WORKDIR}/asl-1.42_pre88"

src_prepare() {
	epatch "${FILESDIR}/${PV}"/*.patch
	
	cp Makefile.def.tmpl Makefile.def
	sed -i "s/^CFLAGS =.*/CFLAGS = ${CFLAGS}/" Makefile.def
	sed -i "s/^LDFLAGS =.*/LDFLAGS = ${LDFLAGS}/" Makefile.def
	sed -i "s,^BINDIR =.*,BINDIR = /usr/bin," Makefile.def
	sed -i "s,^INCDIR =.*,INCDIR = /usr/include/asl," Makefile.def
	sed -i "s,^MANDIR =.*,MANDIR = /usr/share/man," Makefile.def
	sed -i "s,^LIBDIR =.*,LIBDIR = /usr/$(get_libdir)/asl," Makefile.def
	sed -i "s,^DOCDIR =.*,DOCDIR = /usr/share/doc/asl," Makefile.def
}

src_compile() {
	emake || die "Make failed!"

	#emake docs || die "Make doc failed!"
}

src_install() {
	make PREFIX="${D}" install
}