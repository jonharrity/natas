#!/bin/sh
pw=""
for i in {0..31}; do
	newch=$( bash nextch.sh $pw )
	pw=$pw$newch
	echo found $pw
done
echo $pw
