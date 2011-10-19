#!/usr/bin/env python2.7

import simplejson as json
import os
import urllib2
import subprocess
import difflib
import argparse

def getURL(url):
    try:
        req = urllib2.Request(url)
        fp = urllib2.urlopen(req)
    except urllib2.HTTPError, e:
        print e.code
        print e.read()
    return fp

def writeAndCommit(fileName, fileContents, comment):
    githubWadl = open(fileName, 'w')
    
    githubWadl.write(fileContents)
    githubWadl.close()

    subprocess.call(['git', 'add' , '.']) 
    subprocess.call(['git', 'add' , fileName])
    subprocess.call(['git', 'commit' , '-m', comment])

    os.chdir("..")

def repoHandle(dct):
    if os.path.exists(dct['name']):
        os.chdir(dct['name'])
        diffHandle(dct, getURL(dct['wadlUrl'])) 
    else:
        os.mkdir(dct['name'])
        os.chdir(dct['name'])
        wadlHandle(dct, getURL(dct['wadlUrl']))

def wadlHandle(dct, apigeeWadl):
    filename = dct['wadlUrl'].split('/')[-1] \
                             .split('#')[0] \
                             .split('?')[0]

    comment = 'Added directory "{0}" and file "{1}"'.format(dct['name'], filename)

    writeAndCommit(filename, apigeeWadl.read(), comment)

def diffHandle(dct, apigeeWadl):
    fileList = os.listdir(".")

    if len(fileList) > 1:
        multFileDiff(dct, apigeeWadl, fileList)

    elif len(fileList) == 1:
        fc = apigeeWadl.read()

        if difflib.SequenceMatcher(lambda x: x in " \t", fc,fileList[0]).real_quick_ratio() > 0:
            comment = 'Updated file: "{0}" in "{1}" directory'.format(fileList[0], dct['name'])
            writeAndCommit(fileList[0], fc, comment)
        else:
            os.chdir('..')
    else:
        wadlHandle(dct, apigeeWadl)

"""Will get called each time in a new directory"""
def multFileDiff(dct, apigeeWadl, fileList):
    fc = apigeeWadl.read()

    lowestRatio = float
    lowestRatio = difflib.SequenceMatcher(lambda x: x in " \t", fc,fileList[0]).real_quick_ratio()
    lowestFile =  fileList[0]
    for i in fileList[1:]:
        tempRatio = float
        tempRatio = difflib.SequenceMatcher(lambda x: x in " \t", fc,i).real_quick_ratio()
        if tempRatio  < lowestRatio:
            lowestRatio = tempRatio
            lowestFile = i

    if lowestRatio > float(0):
        comment = 'Updated file: "{0}" in "{1}" directory'.format(lowestFile, dct['name'])
        writeAndCommit(lowestFile, fc, comment)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('-d', '--directory', required=False)
    args = parser.parse_args()

    if args.directory:
        os.chdir(args.directory)
    else:
        # Clone git repo to local system
        subprocess.call(['git', 'clone', 'git://github.com/apigee/wadl-library.git', 'wadl-library'])
        os.chdir("wadl-library")

    urlObj = getURL("http://api.apigee.com/v1/consoles.json")
    jsonData = json.load(urlObj)

    map(repoHandle, jsonData['console'])

if __name__ == '__main__':
    main()
