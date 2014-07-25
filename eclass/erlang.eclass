# Copyright (c) 2014 Max Hacking - Hacking Networked Solutions
# Distributed under the terms of the GNU General Public License, v3 or later
# Author: Max Hacking <max.hacking@mad-hacking.net>

# This eclass sets up some useful build system variables for Erlang packages.
#

inherit multilib

DEPEND="dev-lang/erlang"

EXPORT_FUNCTIONS src_compile src_install

: ${ERLANG_LIB_PATH:="/usr/$(get_libdir)/erlang/lib"}
: ${ERLANG_PKG_INSTALL_DIR:="${P}"}
: ${ERLANG_PKG_LINK_DIR:="${PN}"}

: ${ERLANG_DOC_DIRS:="doc docs"}
: ${ERLANG_DOC_FILES:="authors* coding* copyright* license* readme* *note*"}
: ${ERLANG_HTML_DIRS:=""}

: ${ERLANG_CLEAN_FILES:="build.* *.gitignore *.o Makefile* rebar.*"}
: ${ERLANG_CLEAN_DIRS:="api_gen build examples test tests temp tmp"}

erlang_src_compile() {
	emake || die	
}

erlang_src_install() {
	insinto "${ERLANG_LIB_PATH}/${ERLANG_PKG_INSTALL_DIR}"
	dodir "${ERLANG_LIB_PATH}/${ERLANG_PKG_INSTALL_DIR}"
	dosym "${ERLANG_PKG_INSTALL_DIR}" "${ERLANG_LIB_PATH}/${ERLANG_PKG_LINK_DIR}"

	# We need to disable and enable globbing so we store current shell opts.
	local oldSetOptions=$(set +o)
	set -f
		
	# It is really important that ${S} contains something sensible or
	# there is a potential risk that we rm -rf / if someone does something
	# stupid with a regex.
	[[ "${S}" =~ /.*/ ]] || die "\${S}=\"${S}\" - this may not be safe!"
	cd "${S}"

	# We first need to remove any file based cruft, there's probably loads!
	for file in ${ERLANG_CLEAN_FILES}; do
		find . -iname "${file}" -type f -delete
	done

	# Next we need to remove any directory based cruft.
	for file in ${ERLANG_CLEAN_DIRS}; do
		find . -maxdepth 1 -iname "${file}" -type d -exec rm -rf '{}' \;
	done

	# Install (and then delete) the documentation files, directories and HTML directories.
	for doc in ${ERLANG_DOC_FILES}; do
		find . -iname "${doc}" -type f -exec dodoc "{}" \; -exec rm "{}" \;
	done
	set +f
	for doc in ${ERLANG_DOC_DIRS}; do
		if [[ -d "${doc}" ]]; then
			dodoc -r ${doc}/*
			rm -rf "${S}/${doc}"
		fi
	done
	for doc in ${ERLANG_HTML_DIRS}; do
		if [[ -d "${doc}" ]]; then
			dohtml -r ${doc}/*
			rm -rf "${S}/${doc}"
		fi
	done
	
	# We should only be left with the files to install now		
	doins -r *

	# We should leave the shell opts as we found them.
	$oldSetOptions
}
