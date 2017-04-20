# Copyright 2013 Hacking Networked Solutions
# Distributed under the terms of the GNU General Public License v3
# $Header: $

EAPI=5
SLOT="0"

PYTHON_COMPAT=( python3_4 )
inherit distutils-r1

ARCHIVE_FILE="060f6d6782768b1f6a4713f369db2740e79ec61e"

DESCRIPTION="Library to provide a cross-platform GPIO interface on the Raspberry Pi"
HOMEPAGE="https://github.com/adafruit/Adafruit_Python_GPIO"
SRC_URI="https://github.com/adafruit/Adafruit_Python_GPIO/archive/${ARCHIVE_FILE}.zip -> ${P}.zip"

S="${WORKDIR}/Adafruit_Python_GPIO-${ARCHIVE_FILE}"
PATCHES="${FILESDIR}/dont_install_tests.patch"
