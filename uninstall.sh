#!/bin/bash
#

if [[ $UID == 0 ]]; then
	echo "==============================================================="
	echo "Don't run this script with root privilege."
	echo "It is dengerous."
	echo "==============================================================="
	exit
fi

# Check number of parameters
if [[ $# == 0 ]]; then
	echo "No option provided..."
	exit
elif [[ $# > 2 ]]; then
	echo "Nunmer of parameters out of range..."
	echo "No more than 2 parameters can be provided..."
	exit
fi

# Content paths
imgs=/home/$USER/.local/share/backgrounds
backgrounds=/home/$USER/.local/share/gnome-background-properties

# Removing backgrounds created locally
if [[ $1 == '-a' ]]; then
	if [[ $# > 1 ]]; then
		echo "Don't provide any other options with -a"
		exit
	fi

	echo "Removing all locally created backgrounds..."

	rm -rfv $imgs/*
	rm -rfv $backgrounds/*

elif [[ $1 == '-n' ]]; then
	if [[ $# != 2 ]]; then
		echo "Invalid usage of option..."
		exit
	fi

	echo "Removing $2 slideshow..."
	rm -rfv $imgs/$2*
	rm -rfv $backgrounds/$2*
elif [[ $1 == '--help' || $1 == '-h' ]]; then
	if [[ $# != 1 ]]; then
		echo "Use correctly..."
		exit
	fi
	man ./doc/gnomebackground.2
else
	echo "Invalid option..."
	exit
fi
