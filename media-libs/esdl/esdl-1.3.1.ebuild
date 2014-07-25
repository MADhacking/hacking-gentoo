# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/esdl/esdl-1.2.ebuild,v 1.1 2013/02/12 14:41:54 george Exp $

EAPI="2"

inherit rebar

DESCRIPTION="Erlang bindings for the SDL library"
HOMEPAGE="http://esdl.sourceforge.net/"
SRC_URI="mirror://sourceforge/esdl/${P}.src.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-lang/erlang-16[wxwidgets]
	x11-libs/wxGTK[opengl]
	media-libs/libsdl[opengl]
	media-libs/sdl-image
	media-libs/sdl-ttf
	virtual/opengl"
DEPEND="${RDEPEND}"

pkg_setup() {
	ERLANG_DOC_DIRS=""
	ERLANG_HTML_DIRS="doc"
	ERLANG_CLEAN_FILES="${ERLANG_CLEAN_FILES} README-SDL.txt"
}
