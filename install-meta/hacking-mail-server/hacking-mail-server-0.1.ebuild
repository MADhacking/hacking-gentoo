# Copyright 2012 Hacking Networked Solutions
# Distributed under the terms of the GNU General Public License v3

EAPI="3"

DESCRIPTION="Hacking Networked Solutions mail server meta-package"
HOMEPAGE="http://www.hacking.co.uk/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
RDEPEND="${DEPEND}
	install-meta/hacking-base-server
	app-antivirus/clamav
	dev-perl/IP-Country
	mail-filter/amavisd-new
	mail-filter/maildrop
	mail-filter/pypolicyd-spf
	mail-filter/spamassassin
	mail-mta/postfix
	net-mail/fetchmail"