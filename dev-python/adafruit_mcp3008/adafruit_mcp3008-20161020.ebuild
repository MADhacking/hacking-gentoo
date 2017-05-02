# Copyright 2013 Hacking Networked Solutions
# Distributed under the terms of the GNU General Public License v3
# $Header: $

EAPI=5
SLOT="0"

PYTHON_COMPAT=( python3_4 )
inherit distutils-r1

PROJECT_NAME="Adafruit_Python_MCP3008"
ARCHIVE_FILE="e721d26e650c99b0f6d3efd4ec30444e1adf5ccd"

DESCRIPTION="Python library to use the MCP3008 analog to digital converter with a Raspberry Pi or BeagleBone black."
HOMEPAGE="https://github.com/adafruit/${PROJECT_NAME}"
SRC_URI="${HOMEPAGE}/archive/${ARCHIVE_FILE}.zip -> ${P}.zip"

KEYWORDS="arm"

S="${WORKDIR}/${PROJECT_NAME}-${ARCHIVE_FILE}"
#PATCHES="${FILESDIR}/dont_install_tests.patch"
