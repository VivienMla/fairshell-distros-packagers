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

# create build environment
mkdir -p ~/rpmbuild/{BUILD,BUILDROOT,RPMS,SOURCES,SPECS,SRPMS}
echo '%_topdir %(echo $HOME)/rpmbuild' > ~/.rpmmacros

# copy resources
cp -a /tarball.tar.gz ~/rpmbuild/SOURCES

# extract the spec file
mkdir /tmp/ar
pushd /tmp/ar
tar xf /tarball.tar.gz --wildcards "*/packaging/fedora"
popd
specfile=$(find /tmp/ar -name "*.spec")

# build packages
rpmbuild -ba "$specfile"

# copy built packages
find "$HOME/rpmbuild" -name "*.rpm" -exec cp {} /out ";" -exec chown "$UID.$GID" {} ";"
exit 0
