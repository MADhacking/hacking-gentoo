# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/syslog-ng/syslog-ng-3.2.5.ebuild,v 1.8 2012/05/03 18:02:22 jdhore Exp $

EAPI=2
inherit autotools fixheadtails eutils multilib

MY_PV=${PV/_/}
DESCRIPTION="syslog replacement with advanced filtering features"
HOMEPAGE="http://www.balabit.com/products/syslog_ng/"
SRC_URI="http://www.balabit.com/downloads/files/syslog-ng/sources/${PV}/source/syslog-ng_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE="caps hardened ipv6 +pcre selinux spoof-source sql ssl tcpd"
RESTRICT="test"

RDEPEND="
		pcre? ( dev-libs/libpcre )
		spoof-source? ( net-libs/libnet )
		ssl? ( dev-libs/openssl )
		tcpd? ( >=sys-apps/tcp-wrappers-7.6 )
		>=dev-libs/eventlog-0.2.12
		>=dev-libs/glib-2.10.1:2
		caps? ( sys-libs/libcap )
		sql? ( >=dev-db/libdbi-0.8.3 )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	sys-devel/flex"

src_prepare() {
	ht_fix_file configure.in
	eautoreconf
}

src_configure() {
	econf \
		--disable-dependency-tracking \
		--enable-dynamic-linking \
		--sysconfdir=/etc/syslog-ng \
		--localstatedir=/var/lib/misc/syslog-ng \
		--with-pidfile-dir=/var/run/syslog-ng \
		--with-module-dir=/usr/$(get_libdir)/syslog-ng \
		$(use_enable caps linux-caps) \
		$(use_enable ipv6) \
		$(use_enable pcre) \
		$(use_enable spoof-source) \
		$(use_enable sql) \
		$(use_enable ssl) \
		$(use_enable tcpd tcp-wrapper)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc AUTHORS ChangeLog NEWS README \
		contrib/syslog-ng.conf* \
		contrib/syslog2ng "${FILESDIR}/syslog-ng.conf."*

	# Install default configuration
	insinto /etc/syslog-ng
	if use hardened || use selinux ; then
		newins "${FILESDIR}/syslog-ng.conf.gentoo.hardened.${PV%.*}" syslog-ng.conf || die
	elif use userland_BSD ; then
		newins "${FILESDIR}/syslog-ng.conf.gentoo.fbsd.${PV%.*}" syslog-ng.conf || die
	else
		newins "${FILESDIR}/syslog-ng.conf.gentoo.${PV%.*}" syslog-ng.conf || die
	fi

	insinto /etc/logrotate.d
	# Install snippet for logrotate, which may or may not be installed
	if use hardened || use selinux ; then
		newins "${FILESDIR}/syslog-ng.logrotate.hardened" syslog-ng || die
	else
		newins "${FILESDIR}/syslog-ng.logrotate" syslog-ng || die
	fi

	newinitd "${FILESDIR}/syslog-ng.rc6.${PV%%.*}" syslog-ng || die
	newconfd "${FILESDIR}/syslog-ng.confd" syslog-ng || die
	keepdir /etc/syslog-ng/patterndb.d
	find "${D}" -type f -name '*.la' -exec rm {} + || die
}

pkg_preinst() {
	enewgroup syslog 514
	enewuser syslog 514 -1 -1 "syslog,tty"
	gpasswd -a root syslog

	keepdir /var/run/syslog-ng
	fperms 0770 /var/run/syslog-ng
	fowners syslog:syslog /var/run/syslog-ng

	keepdir /var/lib/misc/syslog-ng
	fperms 0770 /var/lib/misc/syslog-ng
	fowners syslog:syslog /var/lib/misc/syslog-ng
}

pkg_postinst() {
	echo
	ewarn "Please note that the standard location of the socket and PID file has changed from"
	ewarn "/var/run/syslog-ng.* to /var/run/syslog-ng/syslog-ng.* and you have to be in the"
	ewarn "'syslog' group to access the control socket or /var/log/messages."
	ewarn "This can break applications which have the standard location hard-coded."
	echo
	if [[ $(stat -c %U /var/log) != "syslog" ]]; then
		ewarn "Forcing new permissions on /var/log and /var/log/messages"
		chown syslog:syslog /var/log
		[[ -e /var/log/messages ]] && chown syslog:syslog /var/log/messages
		echo
	fi

	# bug #355257
	if ! has_version app-admin/logrotate ; then
		echo
		elog "It is highly recommended that app-admin/logrotate be emerged to"
		elog "manage the log files.  ${PN} installs a file in /etc/logrotate.d"
		elog "for logrotate to use."
		echo
	fi
}
