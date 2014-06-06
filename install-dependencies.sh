#!/usr/bin/env bash

DIR="$(cd -P "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")" )" && pwd)"

DEPPKGS="git python-keyring python-gnomekeyring python-setuptools python-pip golang golang-go libgmime-2.6-dev libxapian-dev msmtp-gnome"

sudo apt-get -y update  &&  sudo apt-get -y install ${DEPPKGS}

BUILDDIR_DEF="${HOME}/build"
BUILDDIR="${1:-"${BUILDDIR_DEF}"}"
SRCDIR_DEF="${BUILDDIR}/src"
SRCDIR="${2:-"${SRCDIR_DEF}"}"


# Mutt patched with xlabels
MUTTBUILDDIR="${SRCDIR}/mutt-patched-src"
PATCHFNAME="patch-1.5.21.mp.xlabel_ext.9"

mkdir -p "${BUILDDIR}" "${SRCDIR}" "${MUTTBUILDDIR}"
pushd "${MUTTBUILDDIR}"
 apt-get source mutt-patched
 pushd mutt-*
  cp "${DIR}/mutt/${PATCHFNAME}" .  &&  patch -p1 < "${PATCHFNAME}"
  sudo apt-get build-dep mutt-patched  &&  debuild -us -uc -b
  sudo dpkg -i ../mutt_*.deb  &&  sudo dpkg -i ../mutt-patched*.deb
 popd
popd
rm -rf "${MUTTBUILDDIR}"


# offlineimap
OFFLINEIMAPTAG="v6.5.6"
OFFLINEIMAPBUILDDIR="${BUILDDIR}/offlineimap-${OFFLINEIMAPTAG}"

git clone -b "${OFFLINEIMAPTAG}" git@github.com:OfflineIMAP/offlineimap.git "${OFFLINEIMAPBUILDDIR}"
pushd "${OFFLINEIMAPBUILDDIR}"
 sudo python setup.py install
popd


# maildir-utils
MUTAG="0.9.9.6pre3"
MUBUILDDIR="${SRCDIR}/mu"
MUDIR="${BUILDDIR}/mu"

git clone -b "${MUTAG}" git@github.com:djcb/mu.git "${MUBUILDDIR}"
pushd "${MUTTBUILDDIR}"
 autoreconf -i
 ./configure --prefix="${MUDIR}" --disable-mu4e --disable-gtk --disable-webkit --disable-guile
 make -j5  &&  make install
 make clean
popd

