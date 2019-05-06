#!/bin/bash
v2=$(date -r $1)
while [ true ]
do
	v1=$(date -r $1)
	if [ "$v1" != "$v2" ]
	then
		echo "if"
		pdflatex $1
		v2=$(date -r $1)
	fi
	sleep 0.2;
done
