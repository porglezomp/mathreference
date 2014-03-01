#!/usr/bin/env python

import urllib, sys, re, string, hashlib, base64, os, subprocess

if not os.path.isdir("images/"):
	print "Created 'images/' directory"
	os.mkdir("images/")
NO_IMAGEMAGICK = False
fr = ["\\", " ", "^", "{", "}", "(", ")", "[", "]", "&"]
to = ["",   "",  "",  "",  "",  "",  "",  "",  "",  ""]
regex = re.compile('<img ?(style=".*?")? src="http://(?P<url>.*?)\?(?P<file>.*?)">')
a = sys.stdin.readline()
while a:
	for item in regex.finditer(a):
		fname = "images/"+base64.b64encode(hashlib.sha224(item.group('file')).digest(), "ab")[:15]+".gif"
		if not os.path.isfile(fname):
			urllib.urlretrieve("http://"+item.group('url')+"?"+item.group('file'), fname)
		try:
			if not NO_IMAGEMAGICK: subprocess.Popen(["convert", fname, "-contrast-stretch", "100%", fname])
		except:
			NO_IMAGEMAGICK = True
			sys.stderr.writelines("ERROR: It appears that ImageMagick is not installed, contrast may suffer in equations.")
		a = a.replace("http://"+item.group('url')+"?"+item.group('file'), fname)
	sys.stdout.write(a)
	a = sys.stdin.readline()