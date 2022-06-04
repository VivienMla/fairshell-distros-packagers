#!/bin/bash

# -*- coding: utf-8 -*-
#
# Copyright 2022 Vivien Malerba <vmalerba@gmail.com>
#
# This file is part of FAIRSHELL.
#
# FAIRSHELL is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# FAIRSHELL is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with FAIRSHELL.  If not, see <http://www.gnu.org/licenses/>.

set -e

[ "$http_proxy" == "" ] && unset http_proxy
[ "$https_proxy" == "" ] && unset https_proxy

# soft. install
apt update
apt install -y fakeroot dpkg make

# remove itself
rm -f "$0"
