# Natas Solutions in Bash

### What is Natas?
Natas is a cyber security wargame, and a collection of ~25 web pages written in PHP. Each level/page has a specific vulnerability that can exploited in various ways to find the password to move on to the next level, such as with scripts injections. 
Natas is part of the larger Overthewire site, and can be found at
http://overthewire.org/wargames/natas/

#

Solutions are provided in importable bash functions to Natas levels 15, 16, and 17. Level 18 is in the works.


### Natas15
This level's exploit involves a blind SQL injection attack. To run this program, navigate to the natas15 folder and run the command
```
bash binsearch.sh
```
The attack interprets boolean responses based off of an inserted "less than" comparisons in SQL injection. For each of the 32 characters in the password, a binary search is run to determine the individual character.

### Natas16
Natas16 blocks most Bash operators, but is vulnerable to an inline command injection using the "$( ... )" syntax. Each character of the password is extracted from the known filepath using the "expr" unix command. The resulting list of words is run by the "bestletter.py" python3 script, which determines the case-insensitive character. In the case that the character is a number, there is no output from the level's dictionary, so instead of using "expr", the character is read and translated from 0-9 to a-j using "tr" on the server. A similar method is used to determine the case sensitivity of a letter. Run this attack with the command
```
. condensed.sh ; findall
```

### Natas17


