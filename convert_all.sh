#!/bin/bash

pattern=".vmf"
cfg=".cfg"
forbidden="maps"

for i in * 
do
	if test -d "$i" 
	then
		if [[ $i != $forbidden ]]
		then
			echo "Going through $i"
			for j in $i/* 
			do
				echo "$j"
				if test -f "$j"
				then
					if [[ $j == *$pattern ]]
					then
						echo "Found $j"
						./convert_to_stripper.sh $j
						result="${j/$pattern/$cfg}"
						mv $result maps/
					fi
				fi
			done
		fi
	fi
done
