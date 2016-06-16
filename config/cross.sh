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

dialog --menu "Cross Configuration Options" 40 60 4 \
	1 Native 2 i386 3 bcm2835 4 Custom 2> /tmp/bofos
OPT=$(</tmp/bofos)
if [ $? -eq 0 ]; then
	case $OPT in
	1)
		echo > ${CONFDIR}/cross.cfg
		;;
	2)
		echo "PREFIX := i386-elf-" > ${CONFDIR}/cross.cfg
		;;
	3)
		echo "PREFIX := arm-none-eabi-" > ${CONFDIR}/cross.cfg
		echo "CFLAGS += -mcpu=arm1176jzf-s" > ${CONFDIR}/cross.cfg
		;;
	4)
		dialog --inputbox "CC Prefix" 40 60 2> /tmp/bofos
		PRE=$(</tmp/bofos)
		dialog --inputbox "Cross Compiling CFLAGS" 40 60 2> /tmp/bofos
		CF=$(</tmp/bofos)
		echo "PREFIX := ${PRE}" > ${CONFDIR}/cross.cfg
		echo "CFLAGS += ${CF}" > ${CONFDIR}/cross.cfg
		;;
	esac
fi
