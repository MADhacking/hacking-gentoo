# Copyright 2013 Hacking Networked Solutions
# Distributed under the terms of the GNU General Public License v3
# $Header: $

EAPI=5
SLOT="0"

PYTHON_COMPAT=( python3_4 )
inherit distutils-r1

ARCHIVE_FILE="5e952c2b6cc217e18a666dbfe301644291b7f9dc"

DESCRIPTION="Pure python (i.e. no native extensions) access to Linux IO including I2C and SPI."
HOMEPAGE="https://github.com/adafruit/Adafruit_Python_PureIO"
SRC_URI="https://github.com/adafruit/Adafruit_Python_PureIO/archive/${ARCHIVE_FILE}.zip -> ${P}.zip"

KEYWORDS="arm"

S="${WORKDIR}/Adafruit_Python_PureIO-${ARCHIVE_FILE}"
PATCHES="${FILESDIR}/dont_install_tests.patch"
