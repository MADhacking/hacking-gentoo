# Copyright 2012 Hacking Networked Solutions
# Distributed under the terms of the GNU General Public License v3
# $Header: $

EAPI="3"

inherit eutils cadb unpacker

DESCRIPTION="Common CA Certificates PEM files"
HOMEPAGE="http://packages.debian.org/sid/ca-certificates"
#NMU_PR="1"
SRC_URI="mirror://debian/pool/main/c/${PN}/${PN}_${PV}${NMU_PR:++nmu}${NMU_PR}_all.deb"

LICENSE="MPL-1.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~ppc-aix ~amd64-fbsd ~sparc-fbsd ~x86-fbsd ~x64-freebsd ~x86-freebsd ~hppa-hpux ~ia64-hpux ~x86-interix ~amd64-linux ~arm-linux ~ia64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris ~x86-winnt"
IUSE=""

# platforms like AIX don't have a good ar
DEPEND="kernel_AIX? ( app-arch/deb2targz )
	!<sys-apps/portage-2.1.10.41"

S=${WORKDIR}

IUSE_CERTIFICATE_AUTHORITIES="atrust ac acedicom addtrust affirmtrust aol acf baltimore
buypass cacert camerfirma certigna certinomis certplus certum cnnic comodo comsign
cybertrust dt digicert dst ebg ec entrust equifax geotrust globalsign godaddy hari
hkp igc izenpe japgov juur microsec netlock netsol nl oiste poste quovadis securesign
securetrust seccomm sonera spi strust starfield startcom swisscom swisssign taiwan tc
tdc thawte turktrust twca tubitak utn valenciana valicert verisign visa wells xramp"

for ca in ${IUSE_CERTIFICATE_AUTHORITIES}; do
	IUSE="${IUSE} certificate_authorities_${ca}"
done

pkg_setup() {
	# For the conversion to having it in CONFIG_PROTECT_MASK,
	# we need to tell users about it once manually first.
	[[ -f "${EPREFIX}"/etc/env.d/98ca-certificates ]] \
		|| ewarn "You should run update-ca-certificates manually after etc-update"
}

src_unpack() {
	if [[ -n ${EPREFIX} ]] ; then
		# need to perform everything in the offset, #381937
		mkdir -p "./${EPREFIX}"
		cd "./${EPREFIX}" || die
	fi
	unpack_deb ${A}
}

src_install() {
	# Don't forget to call the eclass src_install function too.
	cadb_src_install

	# Loop through the certindex installing the appropriate certificates
	# depending on the IUSE_CERTIFICATE_AUTHORITIES flag.
	insinto /usr/share/ca-certificates
	while read flag regex; do
		if use "certificate_authorities_${flag}"; then
			find . -type f -iname "${regex}" -exec doins '{}' \;
		fi
	done < "${FILESDIR}/certindex-${PV}.txt"

	# Copy the docs.
	dodoc usr/share/doc/ca-certificates/*

	# Create some /etc dirs.
	dodir /etc/ca-certificates/update.d
	dodir /etc/ssl/certs

	# Create CONFIG_PROTECT_MASK env.d file.
	echo 'CONFIG_PROTECT_MASK="/etc/ca-certificates.conf"' > 98ca-certificates
	doenvd 98ca-certificates
}
