#!/usr/bin/env bash

DIR="$(cd -P "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")" )" && pwd)"

EMAIL_ADDRESS_FILE_LINK="${HOME}/.localmail-custom/username-gmail"
EMAIL_ADDRESS="$(cat "${EMAIL_ADDRESS_FILE_LINK}")"


"${DIR}/msmtprc-generate.sh"
ln -f -s -n "${DIR}/msmtp.rc"     "${HOME}/.msmtprc"
ln -f -s -n "${DIR}/msmtp.log"    "${HOME}/.msmtp.log"

SETTERSCRIPT="msmtp-gnome-tool.py"
cp "/usr/share/doc/msmtp/scripts/msmtp-gnome-tool.py" "${SETTERSCRIPT}"
chmod +x "${SETTERSCRIPT}"
./${SETTERSCRIPT} -s --username "${EMAIL_ADDRESS}" --server "smtp.gmail.com"
rm "${SETTERSCRIPT}"

