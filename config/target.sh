#!/bin/sh
# This file is part of BOFOS, The Broken Out File Operating System.
# Copyright (C) 2016 Ayhan Hakimoglu
#
# BOFOS is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# BOFOS is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with BOFOS.  If not, see <http://www.gnu.org/licenses/>.

dialog --menu "Target Output Options" 40 60 4 \
	1 ELF 2 BIN 2> /tmp/bofos
OPT=$(</tmp/bofos)
if [ $? -eq 0 ]; then
	case $OPT in
	1)
		echo "TARGETS := elf" > ${CONFDIR}/target.cfg
		;;
	2)
		echo "TARGETS := bin" > ${CONFDIR}/target.cfg
		;;
	esac
fi
