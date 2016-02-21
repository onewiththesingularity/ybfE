#! /bin/bash -norc

while read in; do seqApsearch.sh 81 "$in"; done < $1
