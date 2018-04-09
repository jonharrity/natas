# Natas Solutions in Bash

### What is Natas?
Natas is a cyber security wargame, and a collection of ~25 web pages written in PHP. Each level/page has a specific vulnerability that can exploited in various ways to find the password to move on to the next level, such as with scripts injections. 
Natas is part of the larger Overthewire site, and can be found at
http://overthewire.org/wargames/natas/

#

Solutions are provided in importable bash functions to Natas levels 15, 16, and 17. Level 18 is in the works. These attacks use methods including binary searches, text extraction, bash script injections, SQL injections, and time-based blind SQL injections.


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

Natas17 allows for another SQL injection, but unlike Natas15, we receive absolutely no output from the page as to the results of the SQL command. To be able to use information from a SQL injection now, we have to use a timing mechanism. SQL has a built-in "sleep" function, accepting an amount of seconds. In conjunction with SQL's "if" function, we are able to make comparisons on data in the table. The password we are looking for is in this table, and individual characters can be extracted with the "substring" SQL function. From thereon this attack is carried out similarly to the binary search (for each character) that was conducted in Natas15. 
The idea here with the timed attack is that we make comparisons on the character we are trying to deduce, having SQL wait 1-2 seconds if the comparison goes one way (otherwise, normally the entire request will take < 1 second); then time how long the injection takes to determine the output of the SQL command.
Run this attack from the "natas17" folder with the command
'''
. cmds.sh ; findall
'''


### Natas18

The attack on level 18 is still in progress, but the mechanism used will probably involve session hijacking.


