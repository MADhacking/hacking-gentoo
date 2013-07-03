# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-mta/ssmtp/ssmtp-2.64-r2.ebuild,v 1.15 2013/05/26 20:19:07 zx2c4 Exp $

EAPI="4"

PATCHSET=3

WANT_AUTOMAKE=none

inherit eutils autotools user

DESCRIPTION="Extremely simple MTA to get mail off the system to a Mailhub"
HOMEPAGE="ftp://ftp.debian.org/debian/pool/main/s/ssmtp/"
SRC_URI="mirror://debian/pool/main/s/ssmtp/${P/-/_}.orig.tar.bz2
	http://dev.gentoo.org/~flameeyes/ssmtp/${P}-patches-${PATCHSET}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~amd64-fbsd ~sparc-fbsd ~x86-fbsd ~x64-freebsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE="ipv6 +ssl gnutls +mta"

DEPEND="ssl? (
		!gnutls? ( dev-libs/openssl )
		gnutls? ( net-libs/gnutls )
	)"
RDEPEND="${DEPEND}
	net-mail/mailbase
	mta? (
		app-admin/eselect-sendmail
		!net-mail/mailwrapper
		!mail-mta/courier
		!mail-mta/esmtp
		!mail-mta/exim
		!mail-mta/mini-qmail
		!mail-mta/msmtp[mta]
		!mail-mta/nbsmtp
		!mail-mta/netqmail
		!mail-mta/nullmailer
		!mail-mta/qmail-ldap
		!mail-mta/sendmail
		!mail-mta/opensmtpd
	)"

REQUIRED_USE="gnutls? ( ssl )"

pkg_setup() {
	if ! use prefix; then
		enewgroup ssmtp
	fi
}

src_prepare() {
	EPATCH_SUFFIX="patch" EPATCH_SOURCE="${WORKDIR}/patches" \
		epatch
	epatch_user

	# let's start by not using configure.in anymore as future autoconf
	# versions will not support it.
	mv configure.in configure.ac || die

	eautoconf
}

src_configure() {
	econf \
		--sysconfdir="${EPREFIX}"/etc/ssmtp \
		$(use_enable ssl) $(use_with gnutls) \
		$(use_enable ipv6 inet6) \
		--enable-md5auth
}

src_compile() {
	emake etcdir="${EPREFIX}"/etc || die
}

src_install() {
	dosbin ssmtp

	doman ssmtp.8 ssmtp.conf.5
	dodoc ChangeLog CHANGELOG_OLD INSTALL README TLS
	newdoc ssmtp.lsm DESC

	insinto /etc/ssmtp
	doins ssmtp.conf revaliases

	local conffile="${ED}etc/ssmtp/ssmtp.conf"

	# Sorry about the weird indentation, I couldn't figure out a cleverer way
	# to do this without having horribly >80 char lines.
	sed -i -e "s:^hostname=:\n# Gentoo bug #47562\\
# Commenting the following line will force ssmtp to figure\\
# out the hostname itself.\n\\
# hostname=:" \
		"${conffile}" || die "sed failed"

	# Comment rewriteDomain (bug #243364)
	sed -i -e "s:^rewriteDomain=:#rewriteDomain=:" "${conffile}"

	# Set restrictive perms on ssmtp.conf as per #187841, #239197
	# Protect the ssmtp configfile from being readable by regular users as it
	# may contain login/password data to auth against a the mailhub used.
	if ! use prefix; then
		fowners root:ssmtp /etc/ssmtp/ssmtp.conf
		fperms 640 /etc/ssmtp/ssmtp.conf
		fowners root:ssmtp /usr/sbin/ssmtp
		fperms 2711 /usr/sbin/ssmtp
	fi

	if use mta; then
		dosym ../sbin/ssmtp /usr/lib/sendmail.ssmtp
		dosym ../sbin/ssmtp /usr/bin/sendmail.ssmtp
		dosym ssmtp /usr/sbin/sendmail.ssmtp
		dosym ../sbin/ssmtp /usr/bin/mailq.ssmtp
		dosym ../sbin/ssmtp /usr/bin/newaliases.ssmtp
	fi
}

pkg_postinst() {
	if use mta; then
		if [[ ! -L "${ROOT}"/usr/sbin/sendmail ]]; then
			ewarn
			ewarn "You do not currently have a sendmail replacement selected!"
			ewarn
			ewarn "Setting ssmtp as the sendmail replacement"
			ewarn
			eselect sendmail set ssmtp
			ewarn "To use an alternative sendmail replacement use \"eselect sendmail\""
			ewarn
		fi
	
		if ! eselect sendmail show | grep ssmtp &>/dev/null; then
			ewarn
			ewarn "You do not currently have ssmtp selected as a sendmail replacement."
			ewarn
			ewarn "You MUST run"
			ewarn
			ewarn "# eselect sendmail set ssmtp"
			ewarn
			ewarn "if you wish to use ssmtp as a replacement for sendmail."
			ewarn
		fi
	fi
}
