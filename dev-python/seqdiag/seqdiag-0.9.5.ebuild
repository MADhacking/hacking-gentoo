# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
PYTHON_COMPAT=( python2_7 python3_4 )

inherit distutils-r1

DESCRIPTION="seqdiag generates sequence-diagram image from text"
HOMEPAGE="http://blockdiag.com/ https://pypi.python.org/pypi/blockdiag/ https://bitbucket.org/blockdiag/blockdiag/"
SRC_URI="https://pypi.python.org/packages/0c/4d/b15369e167196501d2177bfa22df00acceedece3c2709ccc3089da38cb49/seqdiag-0.9.5.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="
	>=dev-python/funcparserlib-0.3.6[${PYTHON_USEDEP}]
	>=dev-python/pillow-2.2.1[${PYTHON_USEDEP}]
	dev-python/webcolors
"
DEPEND="
	${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? (
		dev-python/mock[${PYTHON_USEDEP}]
		dev-python/nose[${PYTHON_USEDEP}]
		dev-python/reportlab[${PYTHON_USEDEP}]
		dev-python/docutils[${PYTHON_USEDEP}]
		>=dev-python/pep8-1.3[${PYTHON_USEDEP}]
	)
"

python_prepare_all() {
	sed -i -e /build-base/d setup.cfg || die
	distutils-r1_python_prepare_all
}

pkg_postinst() {
	einfo "For additional functionality, install the following optional packages:"
	einfo "    dev-python/reportlab for pdf format"
	einfo "    media-gfx/imagemagick"
	einfo "    wand: https://pypi.python.org/pypi/Wand"
	einfo "          Ctypes-based simple MagickWand API binding for Python"
}
