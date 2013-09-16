#!/usr/bin/env bash

SRCDIR=${1}
TRGDIR=${2}

cd ${SRCDIR}

find -type d -exec mkdir -p ${TRGDIR}/{} \;

for f in $(find -type f); do
    pydelatt.py -o -t ${f} > "${TRGDIR}/${f}"
done

