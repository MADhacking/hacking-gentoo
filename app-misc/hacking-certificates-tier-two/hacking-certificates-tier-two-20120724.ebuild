# Copyright 2012 Hacking Networked Solutions
# Distributed under the terms of the GNU General Public License v3

EAPI="3"

inherit eutils

DESCRIPTION="Hacking Networked Solutions Tier-2 Certificates"
HOMEPAGE="http://ca.hacking.co.uk/"
SRC_URI="http://ca.hacking.co.uk/packages/${P}.tar"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~ppc-aix ~amd64-fbsd ~sparc-fbsd ~x86-fbsd ~x64-freebsd ~x86-freebsd ~hppa-hpux ~ia64-hpux ~x86-interix ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris ~x86-winnt"
IUSE="+nss +openssl +openssh"
RDEPEND="${DEPEND}
	app-admin/update-ca-certificates
	dev-libs/openssl
	nss? ( dev-libs/nss[utils] )
	openssh? ( net-misc/openssh[X509] )"

src_install() {
	# Install into the _local_ certificate store, this is critical as
	# update-ca-certificates will _only_ add certificates located here
	# to the openssh database.
	insinto /usr/local/share/ca-certificates
	doins *
}

pkg_postinst() {
	# Update the certificate databases
	if use nss; then
		ebegin "Updating NSS system certificate database"
		"${EROOT}"/usr/bin/update-ca-certificates --root "${EROOT}" --db-type nss
		eend $?
	fi
	if use openssl; then
		ebegin "Updating OpenSSL certificate database"
		"${EROOT}"/usr/bin/update-ca-certificates --root "${EROOT}" --db-type openssl
		eend $?
	fi
	if use openssh; then
		ebegin "Updating OpenSSH certificate database"
		"${EROOT}"/usr/bin/update-ca-certificates --root "${EROOT}" --db-type openssh
		eend $?
	fi
}
