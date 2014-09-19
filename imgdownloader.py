#!/usr/bin/env python

import urllib
import sys
import re
import string
import hashlib
import base64
import os
import subprocess

if not os.path.isdir("images/"):
    sys.stderr.write("Created 'images/' directory\n")
    os.mkdir("images/")

NO_IMAGEMAGICK = False
fr = ["\\", " ", "^", "{", "}", "(", ")", "[", "]", "&"]
to = ["",   "",  "",  "",  "",  "",  "",  "",  "",  ""]
regex = re.compile('<img ?(style=".*?")? '
                   'src="http://(?P<url>.*?)\?(?P<file>.*?)">')
a = sys.stdin.readline()
while a:
    for item in regex.finditer(a):
        shaname = hashlib.sha224(item.group('file')).digest()
        b64name = base64.b64encode(shaname, "ab")
        fname = "images/" + b64name[:15] + ".gif"
        if not os.path.isfile(fname):
            url = "http://" + item.group('url') + "?" + item.group('file')
            urllib.urlretrieve(url, fname)
        try:
            if not NO_IMAGEMAGICK:
                subprocess.Popen(["convert",
                                  fname,
                                  "-contrast-stretch",
                                  "100%",
                                  fname])
        except:
            NO_IMAGEMAGICK = True
            msg = "ERROR: It appears that ImageMagick is not installed,"\
                  "contrast may suffer in equations."
            sys.stderr.writelines(msg)
        item_url = item.group('url')
        item_file = item.group('file')
        a = a.replace("http://" + item_url + "?" + item_file, fname)
    sys.stdout.write(a)
    a = sys.stdin.readline()
