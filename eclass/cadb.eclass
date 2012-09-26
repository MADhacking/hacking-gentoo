# Copyright (c) 2012 Max Hacking - Hacking Networked Solutions
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Max Hacking <max.hacking@mad-hacking.net>

# This eclass updates the certificate databases associates with the following packages.
#
# icedtea	dev-java/icedtea
# nss		dev-libs/nss
# openssl	dev-libs/openssl
# openssh	net-misc/openssh

inherit eutils

# Ensure that we always have a version of dev-libs/openssl available and
# an appropriate version of update-ca-certificates.

DEPEND="dev-libs/openssl
		 >=app-admin/update-ca-certificates-0.5"

# @FUNCTION: cadb_src_install
# @DESCRIPTION:
# Ensures certificate directories have been created. 

cadb_src_install()
{
	dodir /usr/share/ca-certificates
	dodir /usr/local/share/ca-certificates
}

# @FUNCTION: cadb_update_ca_databases
# @DESCRIPTION:
# Updates the Certificate Authority Databases (CADBs) for all installed
# packages which use them. 

cadb_update_ca_databases() {
	# If no list of databases is provided then we need to figure out for
	# ourselves which databases we need to update.  If a list of databases
	# is provided then we just need to update those.

	if has java "$@" || ( [[ -z "$@" ]] && has_version "virtual/jre" ) \
					 || ( [[ -z "$@" ]] && has_version "virtual/jdk" )
	then
		ebegin "Updating Java certificate database"
		"${EROOT}"/usr/bin/update-ca-certificates --root "${EROOT}" --fresh --db-type java || die
		eend $?
	fi

	if has nss "$@" || ( [[ -z "$@" ]] && has_version "dev-libs/nss" ) 
	then
		ebegin "Updating NSS system certificate database"
		"${EROOT}"/usr/bin/update-ca-certificates --root "${EROOT}" --fresh --db-type nss || die
		eend $?
	fi

	if has openssl "$@" || ( [[ -z "$@" ]] && has_version "dev-libs/openssl" )
	then
		ebegin "Updating OpenSSL certificate database"
		"${EROOT}"/usr/bin/update-ca-certificates --root "${EROOT}" --fresh --db-type openssl || die
		eend $?
	fi

	if has openssh "$@" || ( [[ -z "$@" ]] && has_version "net-misc/openssh[X509]" )
	then
		ebegin "Updating OpenSSH certificate database"
		"${EROOT}"/usr/bin/update-ca-certificates --root "${EROOT}" --fresh --db-type openssh || die
		eend $?
	fi
}

# @FUNCTION: cadb_pkg_postinst
# @DESCRIPTION:
# Updates the Certificate Authority Databases (CADBs) for all installed
# packages which use them. 

cadb_pkg_postinst() {
	cadb_update_ca_databases $@
}

# @FUNCTION: cadb_pkg_postinst
# @DESCRIPTION:
# Updates the Certificate Authority Databases (CADBs) for all installed
# packages which use them. 

cadb_pkg_postrm() {
	# If we are removing the last instance of a package then we need to
	# update the database again, we've just done it if this was an upgrade.
	has_version "${CATEGORY}/${PN}" || cadb_update_ca_databases $@
}

EXPORT_FUNCTIONS src_install pkg_postinst pkg_postrm
