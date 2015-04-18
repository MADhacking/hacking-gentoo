# Copyright 2015 Hacking Networked Solutions
# Distributed under the terms of the GNU General Public License v3
# $Header: $

EAPI="4"

inherit puppet

DESCRIPTION="Installs, configures, and manages RabbitMQ"

RDEPEND="puppet-module/puppetlabs-apt
		 puppet-module/nanliu-staging"
