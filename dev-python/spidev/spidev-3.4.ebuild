# Copyright 2013 Hacking Networked Solutions
# Distributed under the terms of the GNU General Public License v3
# $Header: $

EAPI=5
SLOT="0"

PYTHON_COMPAT=( python3_6 )
inherit distutils-r1

DESCRIPTION="Python bindings for Linux SPI access through spidev"
HOMEPAGE="https://pypi.python.org/pypi/spidev"
SRC_URI="https://files.pythonhosted.org/packages/fb/14/4c2e1640f0cb04862c76d9d76ed7c945b0f67876e503ac02f7f675fe86a0/spidev-3.4.tar.gz"

KEYWORDS="arm"

#S="${WORKDIR}/${PROJECT_NAME}-${ARCHIVE_FILE}"
#PATCHES="${FILESDIR}/dont_install_tests.patch"
