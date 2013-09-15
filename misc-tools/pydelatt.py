#!/usr/bin/python
"""
Copyright (c) 2009 Simeon Franklin

MIT Licensed: see http://www.opensource.org/licenses/mit-license.php

pydelatt.py - Strips attachments from maildir format mail
files. Sample usage:

$ find ./Maildir -mtime +120 -size +3M | xargs -ix pydelatt.py -v 'x'
  ./Maildir/.Sent/cur/1248475062.P16433Q0M984498.server1.test.com:2,S
  Attachment Deleted - application/pdf; charset="UTF-8";
  name="1234.pdf";
  ...
$


See pydelatt.py --help for options...

"""

from optparse import OptionParser
import email
from email import MIMEText


def update_list_from_dict(lst, dct):
    """Update positions in a list with values from a dict.

    Dict keys are assumed to be integers in range for the list.

    >>> lst = ['a', 'b', 'c']
    >>> update_list_from_dict(lst, {1:'x'})
    True
    >>> print(lst)
    ['a', 'x', 'c']

    """
    if dct:
        for i in dct.keys():
            lst[i] = dct[i]
        return True
    else:
        return False


def process_node(part, options):
    """Recursively descend tree - processing sub nodes and
    replacing non-text attachments"""

    if part.is_multipart():
        parts_list = part.get_payload()
        new_parts = {}
        for i, sub_part in enumerate(parts_list):
            replacement = process_node(sub_part, options)
            if replacement is not None:
                new_parts[i] = replacement
        if update_list_from_dict(parts_list, new_parts):
            part.set_payload(parts_list)

    elif part.get_content_maintype() != 'text':
        text = MIMEText.MIMEText("Attachment Deleted - %s \r\n" %
                              part.get("Content-Type"))
        if options.verbose:
            print text.get_payload().strip("\n\r")
        return text
    return None


def main():
    usage = '%prog [-ovt] file'
    parser = OptionParser(usage=usage)
    parser.add_option('-o', '--stdout', action='store_true', default=False,
                      help='Print to stdout instead of modifying file')
    parser.add_option('-v', '--verbose', action='store_true', default=False,
                      help='Verbose')
    parser.add_option('-t', '--test', action='store_true', default=False,
                      help="Don't modify file.")
    (options, args) = parser.parse_args()


    if len(args) != 1:
        raise SystemExit("No filename was specified")

    filename = args[0]
    if options.verbose:
        print(filename)

    msg = email.message_from_file(open(filename, "r"))
    for part in msg.walk():
        if part.is_multipart():
            process_node(part, options)

    txt = msg.as_string()
    if not (options.stdout or options.test):
        out = open(filename, "w")
        out.write(txt)
        out.close()

    if options.stdout:
        print txt


if __name__ == '__main__':
    main()
