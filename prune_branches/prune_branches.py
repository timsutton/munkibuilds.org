#!/usr/bin/env python

#pylint: disable=line-too-long
import json
import os
import shutil
import urllib2

BRANCHES_ROOT = '/var/www/munkibuilds.org/_branches'

def main():
    branch_data = json.loads(urllib2.urlopen('https://api.github.com/repos/munki/munki/branches').read())
    remote_branches = [branch['name'] for branch in branch_data]
    print "Found remote branches: %s" % ', '.join(remote_branches)

    for local_branch in os.listdir(BRANCHES_ROOT):
        local_branch_path = os.path.join(BRANCHES_ROOT, local_branch)
        print "evaluating local branch at %s" % local_branch_path
        if local_branch not in remote_branches:
            print "Found local branch %s not present in remote branches, deleting" % local_branch
            shutil.rmtree(local_branch_path)


if __name__ == '__main__':
    main()
