#!/system/bin/sh
#
#	This file is part of the OrangeFox Recovery Project
# 	Copyright (C) 2026 The OrangeFox Recovery Project
#
#	OrangeFox is free software: you can redistribute it and/or modify
#	it under the terms of the GNU General Public License as published by
#	the Free Software Foundation, either version 3 of the License, or
#	any later version.
#
#	OrangeFox is distributed in the hope that it will be useful,
#	but WITHOUT ANY WARRANTY; without even the implied warranty of
#	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#	GNU General Public License for more details.
#
# 	This software is released under GPL version 3 or any later version.
#	See <http://www.gnu.org/licenses/>.
#
# 	Please maintain this if you use this script or any part of it
#

# create symlinks for all busybox applets
all_busybox_applets() {
local bb=/sbin/busybox;
	[ -f $bb ] && $bb --install -s /sbin;
}

# create symlinks for busybox applets that don't clash with existing commands
selected_busybox_applets_ex() {
local applet;
local bb=/sbin/busybox;
local list=/tmp/bbx_applets.lst;
	[ ! -f $bb -o ] && return;
	$bb --list &> $list;
	for applet in $(cat $list); do
		[ -z "$(which $applet)" ] && ln -sf $bb "/sbin/$applet";
	done
}

# create symlinks for busybox applets, from a predefined list
selected_busybox_applets() {
local applet;
local bb=/sbin/busybox;
local list=/bbx_applets.lst;
	[ ! -f $bb ] && return;
	if [ ! -f $list ]; then
		selected_busybox_applets_ex;
		return;
	fi

	for applet in $(cat $list); do
		ln -sf $bb "/sbin/$applet";
	done
}

# --- #
selected_busybox_applets;
exit 0;
#
