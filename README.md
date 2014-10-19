local-mail-mutt
===============

Integrated set of scripts and configuration files to support usage of Mutt as a modern and complete
e-mail client. This configuration was designed to work with GMail, but with small adjustments
can work with any IMAP provider.

Software used:

 * `Mutt` (1.5.23+)
 * `OfflineIMAP` (6.5.6+ / master)
 * `MSMTP` (1.4.32)
 * `Mu` (maildir-utils) (0.9.9.6+ / master)
 * `Goobook`

In order to use the setup provided in this repository, some files with user-specific configurations
need to be _created_ before running the install script,
and they need to be present in the following locations:

```bash
    ~/.localmail-custom/username-gmail
    ~/.localmail-custom/sig
    ~/.localmail-custom/gmail-personal-config
    ~/.localmail-custom/gmail-personal-mailboxes
    ~/.localmail-custom/gpg-personal-config
```

