# Copyright 2015 Hacking Networked Solutions
# Distributed under the terms of the GNU General Public License v3
# $Header: $

EAPI="4"

inherit puppet

DESCRIPTION="A module to enable easy configuration of an NTP client"

RDEPEND=">=puppet-module/puppetlabs-concat-3.0.0
		 >=puppet-module/hacking-hacking_facts-0.1.0"
