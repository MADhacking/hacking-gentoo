# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

# Config file for /etc/init.d/racoon

# See the manual pages for racoon or run `racoon --help`
# for valid command-line options

RACOON_OPTS="-4"

RACOON_CONF="/etc/racoon/racoon.conf"
RACOON_PSK_FILE="/etc/racoon/psk.txt"
SETKEY_CONF="/etc/ipsec.conf"

# Comment or remove the following if you don't want the policy tables
# to be flushed when racoon is stopped.

RACOON_RESET_TABLES="true"
