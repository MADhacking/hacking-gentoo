# Copyright (c) 2015 Max Hacking - Hacking Networked Solutions
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Max Hacking <max.hacking@mad-hacking.net>

# This eclass installs a puppet module.
#

PUPPET_PROVIDER="${PN%%-*}"
PUPPET_MODULE="${PN#*-}"

HOMEPAGE="https://forge.puppetlabs.com/${PUPPET_PROVIDER}/${PUPPET_MODULE}"
SRC_URI="https://forgeapi.puppetlabs.com/v3/files/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 hppa ~ppc ~sparc x86"

DEPEND=""
RDEPEND="${DEPEND}
		 app-admin/puppet"

# @FUNCTION: puppet_src_install
# @DESCRIPTION:
# Installs the puppet module. 

puppet_src_install()
{
	insinto "/etc/puppet/modules/${PUPPET_MODULE}"
	doins -r *
}

EXPORT_FUNCTIONS src_install
