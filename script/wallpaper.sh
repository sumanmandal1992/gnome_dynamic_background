#!/bin/bash
IFS='
'
arr=($(ls -p $1 | grep -v /))
filepath=$1

#if [[ $1 == '' ]]
#then
#	arr=($(ls -p | grep -v /))
#	filepath=$PWD
#else
#	arr=($(ls -p $1 | grep -v /))
#
#	slash=${1: -1}
#	if [[ $slash == '/' ]]
#	then
#		path=${1: :-1}
#	else
#		path=$1
#	fi
#	filepath=$PWD/$path
#fi

len=${#arr[@]}
echo "<background>"
for (( i=0; $i<$len; i=$i+1 ))
do
	next=$(expr $i + 1)
	echo -e "\t<static>"
	echo -e "\t\t<duration>3600</duration>"
	echo -e "\t\t<file>$filepath/${arr[i]}</file>"
	echo -e "\t</static>"
	echo -e '\t<transition type="overlay">'
	echo -e "\t\t<duration>2</duration>"
	echo -e "\t\t<from>$filepath/${arr[i]}</from>"
	if [[ $next == $len ]]
	then
		echo -e "\t\t<to>$filepath/${arr[0]}</to>"
	else
		echo -e "\t\t<to>$filepath/${arr[next]}</to>"
	fi
	echo -e "\t</transition>"
done
echo "</background>"
