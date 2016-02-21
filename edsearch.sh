#!/bin/bash
set -f
IFS=$'\n'
esearch -db protein -query "ybfE" |\
efetch -format gpc -mode xml |\
xtract -insd complete CDS coded_by > query_results.txt

# for i in $(cat query_results.txt);
#    do echo "$i" | awk '{match($0,"([A-Z0-9\\.]+)\\s+(complement\\()?([A-Z0-9\\.]+):([0-9]+)\\.\\.([0-9]+)(\\))?",a)}END{print a[1], a[3], a[4], a[5]}'
# done

unset IFS
