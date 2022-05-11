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
umask 0022

# verifications
for var in VERSION NAME UID GID
do
    evar=$(eval echo \$$var)
    [ "$evar" != "" ] || {
        echo "Variable $var not specified"
        exit 1
    }
done
version="$VERSION"
appname="$NAME"

[ -d "/out" ] || {
    echo "Missing '/out'"
    exit 1
}

[ -f "/tarball.tar.gz" ] || {
    echo "Missing '/tarball.tar.gz'"
    exit 1
}

# copy resources to TMP directory
tmpdir_src=$(mktemp -d)
cd "$tmpdir_src"
tar xzf /tarball.tar.gz --strip 1

tmpdir_inst=$(mktemp -d)
install -d -m 0755 "$tmpdir_inst/usr/share/doc/$appname"
install -m 644 copyright "$tmpdir_inst/usr/share/doc/$appname"
make install DESTDIR="$tmpdir_inst" INSTALL=/usr/bin/install
gzip -9 packaging/debian/changelog.Debian
install -m 644 packaging/debian/changelog.Debian.gz "$tmpdir_inst/usr/share/doc/$appname"
install -d -m 0755 "$tmpdir_inst/DEBIAN"
install -m 644 packaging/debian/{control,conffiles} "$tmpdir_inst/DEBIAN"
install -m 755 packaging/debian/{postinst,prerm} "$tmpdir_inst/DEBIAN"

# create DEB
debfile="fairshell-$appname-$version.deb"
stdtmp=$(mktemp)
fakeroot dpkg-deb --build "$tmpdir_inst" "/out/$debfile" > "$stdtmp" 2>&1 || {
    echo "Failed: "
    cat "$stdtmp"
    rm -f "$stdtmp"
    exit 1
}
rm -f "$stdtmp"
chown "$UID.$GID" "/out/$debfile"
exit 0
