# Copyright 2010 Hacking Networked Solutions
# Based on the original ebuild provided by Gentoo Linux 
# Distributed under the terms of the GNU General Public License v2

inherit eutils flag-o-matic autotools linux-info

NEW_P=${P//_/-}

DESCRIPTION="A port of KAME's IPsec utilities to the Linux-2.6 IPsec implementation"
HOMEPAGE="http://ipsec-tools.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${NEW_P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="idea ipv6 pam rc5 readline selinux ldap kerberos nat broken-natt hybrid iconv selinux"

DEPEND_COMMON="
	selinux? ( sys-libs/libselinux )
	readline? ( sys-libs/readline )
	pam? ( sys-libs/pam )
	ldap? ( net-nds/openldap )
	kerberos? ( virtual/krb5 )
	>=dev-libs/openssl-0.9.8
	iconv? ( virtual/libiconv )"

RDEPEND="${DEPEND_COMMON}"

DEPEND="${DEPEND_COMMON}
	>=sys-kernel/linux-headers-2.6.30"

pkg_setup() {
	get_version
	if kernel_is 2 6 ; then
		if test "${KV_PATCH}" -ge 19 ; then
		# Just for kernel >=2.6.19
			einfo "Checking for suitable kernel configuration (Networking | Networking support | Networking options)"

			if use nat; then
				CONFIG_CHECK="${CONFIG_CHECK} ~NETFILTER_XT_MATCH_POLICY"
				export WARNING_NETFILTER_XT_MATCH_POLICY="NAT support may fail weirdly unless you enable this option in your kernel"
			fi

			for i in XFRM_USER NET_KEY; do
				CONFIG_CHECK="${CONFIG_CHECK} ~${i}"
				eval "export WARNING_${i}='No tunnels will be available at all'"
			done

			for i in INET_IPCOMP INET_AH INET_ESP \
				INET_XFRM_MODE_TRANSPORT \
				INET_XFRM_MODE_TUNNEL \
				INET_XFRM_MODE_BEET ; do
				CONFIG_CHECK="${CONFIG_CHECK} ~${i}"
				eval "export WARNING_${i}='IPv4 tunnels will not be available'"
			done

			for i in INET6_IPCOMP INET6_AH INET6_ESP \
				INET6_XFRM_MODE_TRANSPORT \
				INET6_XFRM_MODE_TUNNEL \
				INET6_XFRM_MODE_BEET ; do
				CONFIG_CHECK="${CONFIG_CHECK} ~${i}"
				eval "export WARNING_${i}='IPv6 tunnels will not be available'"
			done

			CONFIG_CHECK="${CONFIG_CHECK} ~CRYPTO_NULL"
			export WARNING_CRYPTO_NULL="Unencrypted tunnels will not be available"
			export CONFIG_CHECK

			check_extra_config
		else
			eerror "You must have a kernel >=2.6.19 to run ipsec-tools."
			eerror "Building now, assuming that you will run on a different kernel"
		fi
	fi
}

src_unpack() {
	unpack ${A}
	S="${WORKDIR}/${NEW_P}"
	cd "${S}"

	# fix for bug #124813
	sed -i 's:-Werror::g' "${S}"/configure.ac

	AT_M4DIR="${S}" eautoreconf
	epunt_cxx
}

src_compile() {
	# fix for bug #61025
	filter-flags -march=c3

	myconf="--with-kernel-headers=/usr/include \
			--enable-dependency-tracking \
			--enable-dpd \
			--enable-frag \
			--enable-stats \
			--enable-adminport \
			$(use_enable ipv6) \
			$(use_enable rc5) \
			$(use_enable idea) \
			$(use_enable broken-natt) \
			$(use_with readline) \
			$(use_enable kerberos gssapi) \
			$(use_with ldap libldap) \
			$(use_with pam libpam)"

	use nat && myconf="${myconf} --enable-natt --enable-natt-versions=00,01,02,03,04,05,06,07,08,rfc"

	# we only need security-context when using selinux
	myconf="${myconf} $(use_enable selinux security-context)"

	# enable mode-cfg and xauth support
	if use pam; then
		myconf="${myconf} --enable-hybrid"
	else
		myconf="${myconf} $(use_enable hybrid)"
	fi

	# dev-libs/libiconv is hard masked
	#use iconv && myconf="${myconf} $(use_with iconv libiconv)"

	# the default (/usr/include/openssl/) is OK for Gentoo, leave it
	# myconf="${myconf} $(use_with ssl openssl )"

	# No way to get it compiling with freeradius or gnuradius
	# We would need libradius which only exists on FreeBSD

	# See bug #77369
	#myconf="${myconf} --enable-samode-unspec"

	econf ${myconf} || die
	emake -j1 || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	keepdir /var/lib/racoon
	newconfd "${FILESDIR}"/racoon.conf.d racoon
	newinitd "${FILESDIR}"/racoon.init.d racoon

	dodoc ChangeLog README NEWS
	dodoc src/racoon/samples/*
	dodoc src/racoon/doc/*

	docinto roadwarrior
	dodoc src/racoon/samples/roadwarrior/*

	docinto roadwarrior/client
	dodoc src/racoon/samples/roadwarrior/client/*
	docinto roadwarrior/server
	dodoc src/racoon/samples/roadwarrior/server/*

	docinto setkey
	dodoc src/setkey/sample.cf

	dodir /etc/racoon

	# RFC are only available from CVS for the moment, see einfo below
	#docinto "rfc"
	#dodoc ${S}/src/racoon/rfc/*
}

pkg_postinst() {
	if use nat; then
		elog
		elog " You have enabled the nat traversal functionnality."
		elog " Nat versions wich are enabled by default are"
		elog " 00,01,02,03,04,05,06,07,08,rfc"
		elog " You can find those drafts in the CVS repository:"
		elog " cvs -d anoncvs@anoncvs.netbsd.org:/cvsroot co ipsec-tools"
		elog
	fi;

	if use ldap; then
		elog
		elog " You have enabled ldap support with {$PN}."
		elog " The man page does NOT contain any information on it yet."
		elog
	fi;

	elog
	elog "Please have a look in /usr/share/doc/${P} and visit"
	elog "http://www.netbsd.org/Documentation/network/ipsec/"
	elog "to find a lot of information on how to configure this great tool."
	elog
}

# vim: set foldmethod=marker nowrap :
