# Copyright 2019 MAD Hacking
# Distributed under the terms of the GNU General Public License v2

EAPI=5
SLOT=0

USE_RUBY="ruby23 ruby24 ruby25"

inherit flag-o-matic ruby-fakegem versionator

LICENSE="GPL-2"
DESCRIPTION="HA Web Konsole (Hawk). A web-based GUI for managing and monitoring Pacemaker HA clusters."
HOMEPAGE="http://clusterlabs.org/wiki/Hawk"
SRC_URI="https://github.com/ClusterLabs/hawk/archive/hawk-${PV}.tar.gz"

KEYWORDS="~amd64"
DEPEND="sys-cluster/pacemaker
	sys-cluster/crmsh
	sys-libs/pam
	dev-libs/glib
	dev-libs/libxml2
	>=dev-ruby/rails-5.1"
RDEPEND="${DEPEND}"

ruby_add_bdepend "
	virtual/rubygems
	dev-ruby/bundler
"

ruby_add_rdepend "
	www-servers/puma
	dev-ruby/sass-rails
	dev-ruby/virtus
	dev-ruby/fast_gettext
	dev-ruby/gettext_i18n_rails
	dev-ruby/sprockets
	dev-ruby/kramdown
	virtual/ruby-threads
"

base="/usr/lib/hawk"

all_ruby_unpack() {
	${unp}_src_unpack
	[ -d "$S" ] || mv "${S}"* "$S" || die
}

all_ruby_prepare() {
	append-flags ${LDFLAGS}
	export RAILS_ENV=production
#	local c="${S}/scripts/${PN}.gentoo.in"
#	[ -e "$c" ] || cp "${FILESDIR}/${PN}.gentoo.in" "$c" || die
#	if has_version '>=dev-ruby/rails-4.0.0'; then
#		sed -i -e "s:gem 'rails', '~> 3\.2':gem 'rails', '>= 3.2'\ngem 'activeresource', '>= 4.0.0':" "${S}"/hawk/Gemfile
#		sed -i -e 's%^\( *match .*\)$%\1, :via => [:get]%' "$S/hawk/config/routes.rb"
#	fi
}

_make(){
	emake WWW_BASE="${base}" INIT_STYLE=gentoo DESTDIR="${D}" "${@}" || die
}

each_ruby_compile() {
	_make
}

each_ruby_install() {
#	rm -f "${D}${base}/${PN}"/public/monitor
	_make install
#	use fcgi || rm "${D}"/srv/www/hawk/config/lighttpd.conf
}

each_ruby_test() {
	_make test
}
