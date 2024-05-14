#!/bin/bash

# podman cp /usr/lib/rpm/macros.d/macros.cmake $ID:/usr/lib/debbuild/macros.d

ID=ss_deb
BTOP=/home/build/debbuild
SARC=solvespace_qt-3.1.tar.gz
PKG=solvespace-qt_3.1-0debian12_amd64.deb

if [ ! -s /tmp/$SARC ]; then
	curl -sL https://github.com/WickedSmoke/solvespace_qt5/releases/download/v3.1-qt/$SARC -o /tmp/$SARC
fi
debspec.b solvespace-qt.spec >/tmp/solvespace-qt.spec

#podman run -d -it --name=$ID dev/debian12 /bin/bash || exit
podman cp /tmp/solvespace-qt.spec $ID:/tmp
podman cp /tmp/$SARC $ID:$BTOP/SOURCES
podman exec -it $ID debbuild -bb /tmp/solvespace-qt.spec || exit
podman cp $ID:$BTOP/DEBS/amd64/$PKG /tmp
