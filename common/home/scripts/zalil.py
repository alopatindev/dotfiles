#!/usr/bin/python2
# -*- coding: utf-8 -*-
#
# HTTP file uploader example for Python 2


import MultipartPostHandler
import urllib2
import cookielib
import sys


if len(sys.argv) < 2:
    print 'usage: %s path/to/filename' % sys.argv[0]
    sys.exit(1)

#cookies = cookielib.CookieJar()
cookies = cookielib.MozillaCookieJar()
opener = urllib2.build_opener(urllib2.HTTPCookieProcessor(cookies),
                              MultipartPostHandler.MultipartPostHandler)
#urllib2.install_opener(opener)
params = {
    "file": open(sys.argv[1], "rb")
}
text = opener.open("http://zalil.ru/upload/", params).read().decode('cp1251')
print text.split('<div align="center">')[1].split('<')[0]
