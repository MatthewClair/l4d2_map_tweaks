#!/bin/bash

echo "add:" > "${1%%.*}".cfg

tr -d '\r' < $1 |\
	awk '/^{\r?$/ { foundStart = 1; goodBlock = 0; foundEnd = 0; includeLine = 0 } /^}\r?$/ { foundEnd = 1 } /nfcrx_tweaks/ { if (foundStart == 1) { goodBlock = 1 }} /origin/ { includeLine = 1 } /solid/ { includeLine = 1 } /angles/ { includeLine = 1 } /model/ { includeLine = 1 } /classname/ { includeLine = 1 } /targetname/ { includeLine = 1 } /parentname/ { includeLine = 1 } foundStart { if (includeLine == 1) { s = s"\n"$0; includeLine = 0; } } foundEnd { if (goodBlock == 1) { print "{"s"\n}"; goodBlock = 0; foundStart = 0; foundEnd = 0 }; s = "" }' \
	| sed -e 's/parentname/targetname/' >> "${1%%.*}".cfg

exit

##### Awk script multiline #####
#!/bin/awk -f
/^{\r?$/ { foundStart = 1; goodBlock = 0; foundEnd = 0; includeLine = 0 }
	/^}\r?$/ { foundEnd = 1 }
	/nfcrx_tweaks/ { if (foundStart == 1) { goodBlock = 1 }}
	/origin/ { includeLine = 1 }
	/solid/ { includeLine = 1 }
	/angles/ { includeLine = 1 }
	/model/ { includeLine = 1 }
	/classname/ { includeLine = 1 }
	/targetname/ { includeLine = 1 }
	/parentname/ { includeLine = 1 }
	foundStart { if (includeLine == 1) { s = s"\n"$0; includeLine = 0; } }
	foundEnd { if (goodBlock == 1) { print "{"s"\n}"; goodBlock = 0; foundStart = 0; foundEnd = 0 }; s = "" }

# vim: wrap
