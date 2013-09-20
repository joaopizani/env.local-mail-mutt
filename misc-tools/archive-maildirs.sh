#!/usr/bin/env bash

MUTTSRCDIR="${HOME}/.mail"
IRCSRCDIR="${HOME}/comm/irclogs"
FINALTRGDIR="${HOME}/data/comm-backup"

COMMTMPDIR="/tmp"
FMTDATE=$(date '+%Y-%m-%d')
COMMBKPNAME="comm_bkp_${FMTDATE}"
COMMBKPINI="${COMMTMPDIR}/${COMMBKPNAME}"
MUTTBKPDIR="${COMMBKPINI}/mutt"
IRCBKPDIR="${COMMBKPINI}/irclogs"
mkdir -p ${MUTTBKPDIR} ${IRCBKPDIR}

${HOME}/bin/delatt-maildir.sh ${MUTTSRCDIR} ${MUTTBKPDIR}
cp -r "${IRCSRCDIR}/" "${IRCBKPDIR}/"

tar -cf - -C ${COMMTMPDIR} ${COMMBKPNAME} | gzip -9 - > "${COMMBKPINI}.tar.gz"
mv "${COMMBKPINI}.tar.gz" "${FINALTRGDIR}/"
rm -rf ${COMMBKPINI}
