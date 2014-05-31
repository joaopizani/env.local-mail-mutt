#!/usr/bin/env bash

DIR="$(cd -P "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")" )" && pwd)"

DEPPKGS="git python-keyring python-gnomekeyring python-pip golang golang-go libgmime-2.6-dev libxapian-dev msmtp-gnome"

sudo apt-get update  &&  sudo apt-get install ${DEPPKGS}

BUILDDIR_DEF="${HOME}/build"
BUILDDIR="${1:-"${BUILDDIR_DEF}"}"
SRCDIR_DEF="${BUILDDIR}/src"
SRCDIR="${2:-"${SRCDIR_DEF}"}"


# Mutt patched with xlabels
MUTTBUILDDIR="${SRCDIR}/mutt-patched-src"
PATCHFNAME="patch-1.5.21.mp.xlabel_ext.9"

mkdir -p "${BUILDDIR}" "${SRCDIR}" "${MUTTBUILDDIR}"
cd "${MUTTBUILDDIR}"
apt-get source mutt-patched
cd mutt-*
cp "${DIR}/mutt/${PATCHFNAME}" .  &&  patch -p1 < "${PATCHFNAME}"
sudo apt-get build-dep mutt-patched  &&  debuild -us -uc -b
sudo dpkg -i ../mutt_*.deb  &&  sudo dpkg -i ../mutt-patched*.deb
rm -rf "${MUTTBUILDDIR}"

# offlineimap  maildir-utils  
