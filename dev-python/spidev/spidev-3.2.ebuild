# Copyright 2013 Hacking Networked Solutions
# Distributed under the terms of the GNU General Public License v3
# $Header: $

EAPI=5
SLOT="0"

PYTHON_COMPAT=( python3_4 )
inherit distutils-r1

DESCRIPTION="Python bindings for Linux SPI access through spidev"
HOMEPAGE="https://pypi.python.org/pypi/spidev"
SRC_URI="https://pypi.python.org/packages/36/83/73748b6e1819b57d8e1df8090200195cdae33aaa22a49a91ded16785eedd/spidev-3.2.tar.gz"

KEYWORDS="arm"

#S="${WORKDIR}/${PROJECT_NAME}-${ARCHIVE_FILE}"
#PATCHES="${FILESDIR}/dont_install_tests.patch"
