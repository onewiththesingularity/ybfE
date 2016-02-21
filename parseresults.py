#!/usr/bin/env python

import os, sys, re

def parse_results(results):
    for line in results.readlines():
        r = parse_line(line)
        if r != None:
            print "{} {} {} {}".format(*r)

def parse_line(line):
    """
    Parses a single line of results
    """
    if re.match(r'^\s+$', line):
        return None
    complement = False
    genome, start, end = [None, None, None]
    gene_id, rest = line.split('\t')
    m = re.match(r'^(complement\()(.+?)(?:\))$', rest)
    if m:
        complement = True
        rest = m.group(2)
    m = re.match(r'^(.+?):(\d+)\.\.(\d+)$', rest)
    if m:
        genome = m.group(1)
        # If its a complement strand, reverse the start and end
        if complement:
            start, end = m.group(3), m.group(2)
        else:
            start, end = m.group(2), m.group(3)

    return (gene_id, genome, start, end)

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print "Supply query results file path as argument to script"
        exit(1)

    query_results = open(os.path.abspath(sys.argv[1]))
    parse_results(query_results)
