#! /bin/bash -norc

# Bash shell script for use with Entrez Direct
bases=1500
if [ -n "$1" ]
then
    bases=$1
fi

while read id accn start stop
do
    if [[ $start -eq 0 || $stop -eq 0 || $start -eq $stop ]]
    then
	echo "Skipping $id due to ambiguous coordinates"
	continue
    fi
    if [ $start -gt $stop ]
    then
	stop=$(( $start + $bases ))
	start=$(( $stop ))
	strand=2
    else
	stop=$(( $stop ))
	start=$(( $start - $bases ))
	strand=1
    fi
        rslt=`efetch -db nuccore -id $accn -format fasta \
          -seq_start $start -seq_stop $stop -strand $strand < /dev/null`
	echo "$rslt"
	  done
