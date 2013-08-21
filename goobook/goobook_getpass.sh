#!/usr/bin/env python

import keyring
print keyring.get_password("localmail-gmail","joaopizani@gmail.com")
