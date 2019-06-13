#!/usr/bin/env python

import sys
import urllib2
import re

class HeadRequest(urllib2.Request):
    def get_method(self):
        return "HEAD"

def launder(url):
    if (re.match(r"^http", url)):
        return url
    else:
        return "http://" + url

if (len(sys.argv) != 2):
    sys.exit("Provide a single URL as an argument.")

try:
    response = urllib2.urlopen(HeadRequest(launder(sys.argv[1])))
    print response.geturl()
except ValueError as e:
    print e.args
except urllib2.HTTPError as e:
    print e
except urllib2.URLError as e:
    print "invalid domain?"
