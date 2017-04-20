# Copyright 2013 Hacking Networked Solutions
# Distributed under the terms of the GNU General Public License v3
# $Header: $

EAPI=5
SLOT="0"

PYTHON_COMPAT=( python3_4 )
inherit distutils-r1

ARCHIVE_FILE="87433eecc2d4c3e11e2a20e7ea83b44aec09002a"

DESCRIPTION="Library to provide a cross-platform GPIO interface on the Raspberry Pi"
HOMEPAGE="https://github.com/adafruit/Adafruit_Python_BME280"
SRC_URI="https://github.com/adafruit/Adafruit_Python_BME280/archive/${ARCHIVE_FILE}.zip -> ${P}.zip"

KEYWORDS="arm"

DEPEND="dev-python/adafruit_gpio[${PYTHON_USEDEP}]"

S="${WORKDIR}/Adafruit_Python_BME280-${ARCHIVE_FILE}"
PATCHES="${FILESDIR}/setup.py.patch"
