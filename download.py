#!/usr/bin/env python
import json, urllib2, hashlib, re, os, sys

# Get the current working directory
cwd = os.path.dirname(os.path.abspath(__file__))

# First we need to get the version data and the token form the download page
version, token = re.findall(
	r'data-url="http://downloads.nessus.org/nessus3dl.php\?file=pvs-(\d+\.\d+\.\d+)-es7.x86_64.rpm&amp;licence_accept=yes&amp;t=([\w\d]+)"', 
	urllib2.urlopen('http://www.tenable.com/products/nessus-network-monitor/download').read()
)[0]

# If the user just requested what the current Nessus Monitor version is, spit it out and bail.
if len(sys.argv) > 1 and sys.argv[1] == 'version':
	print version
	exit(0)

# Now lets download the file and save it to a known location
with open(os.path.join(cwd, 'NessusMonitor.rpm'), 'wb') as rpm:
	rpm.write(urllib2.urlopen(
		'http://downloads.nessus.org/nessus3dl.php?file=pvs-{}-es7.x86_64.rpm&licence_accept=yes&t={}'.format(version, token)).read())