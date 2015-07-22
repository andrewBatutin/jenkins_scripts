#!/usr/bin/python

import sys, getopt

def main(argv):
    inputfile = ''
    try:
        opts, args = getopt.getopt(argv, "hi:", ["ifile="])
    except getopt.GetoptError:
        print '-i <mobileprovisionprofile>'
        sys.exit(2)
    for opt, arg in opts:
        if opt == '-h':
            print '-i <mobileprovisionprofile>'
            sys.exit()
        elif opt in ("-i", "--ifile"):
            inputfile = arg
    res = parseProfile(inputfile)
    sys.stdout.write(res)
    sys.stdout.flush()
    sys.exit(0)

def parseProfile(file):
    uuid_line = -1
    key = ''
    with open(file, 'r') as inF:
        for num, line in enumerate(inF, 1) :
            if 'UUID' in line:
               uuid_line = num
               key = next(inF)
    if key:
        resultkey = key.replace('<string>','').replace('</string>','').strip()            
        return resultkey
    else:
        print 'uuid not found'
        sys.exit(2)

if __name__ == "__main__":
    main(sys.argv[1:])
	
