#!/usr/bin/env python2.7

from sys import argv
import re
from os import listdir, chdir 
from os.path import isfile, join, dirname, basename
import subprocess

mime_cache = { }

def build_mime_cache():
    global mime_cache
    with open('/etc/mime.types', 'r') as fd:
        for line in fd.readlines():
            match = re.match(r'image/[^\s]+(.+)', line.rstrip())
            if match:
                for ext in re.findall(r'[\w]+', match.group(1)):
                    mime_cache[ext] = True

def is_image(filename):
    match = re.search(r'\.(\w+)$', filename)
    if not match:
        return False
    extension = match.group(1)

    assert(len(mime_cache) > 0)
    
    return isfile(filename) and extension.lower() in mime_cache

def get_file_list(directory="."):
    return [f for f in listdir(directory) if is_image(join(directory, f))]

def convert_name(filename):
    def convert_number(matchobj):
        return "{0:018}".format(int(matchobj.group(0)))
    return re.sub(r'\d+', convert_number, filename)

def resort_file_list(l):
    l.sort(key=lambda f: convert_name(f))

def launch_viewer(startfile=None):
    l = get_file_list()
    assert(len(l) > 0)
    resort_file_list(l)

    cmd = ["sxiv"]
    if startfile is not None:
        assert(startfile in l)
        cmd += ['-n', str(l.index(startfile) + 1)]
    cmd += ['--']
    cmd += l

    print(cmd)
    subprocess.check_output(cmd)

if __name__ == "__main__":
    build_mime_cache()
    startfile = None

    if len(argv) > 1:
        start_arg = argv[1]
        if is_image(start_arg):
            if dirname(start_arg) != "":
                chdir(dirname(start_arg))
            startfile = basename(start_arg)

    launch_viewer(startfile)
