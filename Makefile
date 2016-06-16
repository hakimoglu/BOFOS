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

export SRCDIR := src
export CONFDIR := config
export BINDIR := bin

# These should generate the .cfg files.
SHFILES := $(shell find $(CONFDIR) -type f -name "*.sh")
# Output config files.
CFGFILES := $(shell find $(CONFDIR) -type f -name "*.cfg")
# .c files, updated by the config files.
CFILES :=
# .s files, updated by the config files.
SFILES :=
DFILES := $(shell find $(BINDIR) -type f -name "*.d")
# .o files, updated by the config files.
OFILES :=
# Linker script.
LINKER := ${SRCDIR}/linker.ld

WARNINGS := -Wall -Wextra -pedantic -Wshadow -Wpointer-arith -Wcast-align \
		-Wwrite-strings -Wmissing-prototypes -Wmissing-declarations \
		-Wredundant-decls -Wnested-externs -Winline -Wno-long-long \
		-Wuninitialized -Wconversion -Wstrict-prototypes

# Cross compile prefix.
PREFIX :=
# Flags defined by configs.
CFLAGS := $(WARNINGS)
LDFLAGS :=

CC = $(PREFIX)gcc
OBJCOPY = $(PREFIX)objcopy

# Targets, defined by config. Example: bin, elf, etc,
TARGETS :=

-include $(CFGFILES)
-include $(DFILES)

all : $(patsubst %,bin/bofos.%,$(TARGETS))

bin/bofos.bin : bin/bofos.elf
	$(OBJCOPY) -O binary $< $@

bin/bofos.elf : $(OFILES) $(CFGFILES)
	$(CC) -T $(LINKER) -o $@ $(LDFLAGS) $(OFILES)

%.o : %.s Makefile
	$(CC) $(CFLAGS) -c $< -o $@
%.o : %.c Makefile
	$(CC) $(CFLAGS) -MMD -MP -c $< -o $@

config :
	$(patsubst %,sh %;,$(SHFILES))

clean :
	-rm $(OFILES) $(DFILES)

cfgclean :
	-rm $(CFGFILES)

.PHONY : all config clean cfgclean
