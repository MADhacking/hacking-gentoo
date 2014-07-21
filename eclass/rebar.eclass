# Copyright (c) 2014 Max Hacking - Hacking Networked Solutions
# Distributed under the terms of the GNU General Public License, v3 or later
# Author: Max Hacking <max.hacking@mad-hacking.net>

# This eclass provides a basic dev-util/rebar based build system for Erlang packages.
#

EXPORT_FUNCTIONS src_compile

DEPEND="dev-util/rebar"

rebar_src_compile() {
	rebar compile
}