# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/wings/wings-1.1.1.ebuild,v 1.5 2009/12/11 19:53:28 ranger Exp $

EAPI="2"

inherit erlang

DESCRIPTION="Excellent 3D polygon mesh modeler"
HOMEPAGE="http://www.wings3d.com/"
SRC_URI="mirror://sourceforge/wings/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-lang/erlang-17.0
	dev-libs/erlang-cl
	>=media-libs/esdl-1.3.1
	media-libs/libsdl[opengl]"
DEPEND="${RDEPEND}"

pkg_setup() {
	ESDL_PATH="${ERLANG_LIB_PATH}/esdl"
	ERLANG_CLEAN_FILES="${ERLANG_CLEAN_FILES} WINGS-VERSION-GEN"
	ERLANG_CLEAN_DIRS="${ERLANG_CLEAN_DIRS} fonts_src icons intl_tools macosx patches psd tools unix win32"
}
