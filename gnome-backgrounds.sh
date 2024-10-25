#!/bin/bash
#

# Avoiding root privilege
if [[ $UID == 0 ]]; then
	echo "==============================================================="
	echo "* Don't run this script with root privilege."
	echo "* It is dengerous."
	echo "==============================================================="
	exit
fi

# Checking number of arguments
if [[ $# > 4 ]]; then
	echo "==============================================================="
	echo "* Number of arguments out of range..."
	echo "==============================================================="
	exit
elif [[ $# == 3 ]]; then
	echo "==============================================================="
	echo "* Invalid usage of arguments..."
	echo "==============================================================="
	exit
elif [[ $# == 1  &&  $1 != '-q' && $1 != '--help' && $1 != '-h' ]]; then
	echo "==============================================================="
	echo "* Invalid usage of arguments..."
	echo "==============================================================="
	exit
fi


# Set required variables
imgsout=/home/$USER/.local/share/backgrounds
wallpaper=''

background=/home/$USER/.local/share/gnome-background-properties
default=backgrounds
permanent=''
imgsin=''

if [[ $1 == '-q' ]]; then
	if [[ $# > 1 ]]; then
		echo "Invalid use of option..."
		exit
	fi
	/bin/bash $PWD/script/query.sh $imgsout
	exit
fi

# Preparing the use of options.
# If '--help' or '-h' flag is provided.
if [[ $1 == '--help' || $1 == '-h' ]]; then
	man ./doc/gnomebackground.1
	exit
fi
# If '-d' flag is provided.
echo "==============================================================="
echo "* Check wheather the directory exist or not..."

if [[ $1 == '-d' || $3 == '-d' ]]; then
	imgdir=''
	if [[ $1 == '-d' ]]; then
		imgdir=$2;
	elif [[ $3 == '-d' ]]; then
		imgdir=$4
	fi

	if [[ -d $imgdir ]]; then
		slash=${imgdir: -1}
		path=''
		if [[ $slash == '/' ]]; then
			path=${imgdir: :-1}
		else
			path=$imgdir
		fi
		imgsin=$path
	else
		echo "Directory doesn't exist."
		echo "Give the path of image directory."
		exit
	fi
else
	imgsin=$PWD/Images
	echo "'-d' option is not provided or incorrectly provided..."
	echo "Copying images from: $PWD/Images"
fi
echo "==============================================================="
echo ""

# If -o flag is provided
echo "==============================================================="
echo "* Output directory for images"

if [[ $1 == '-o' || $3 == '-o' ]]; then
	imgdir=''
	if [[ $1 == '-o' ]]; then
		imgdir=$2
	elif [[ $3 == '-o' ]]; then
		imgdir=$4
	fi
		wallpaper=$imgsout/$imgdir.xml
		imgsout=$imgsout/$imgdir
		permanent=$background/$imgdir.xml
else
	imgsout=$imgsout/$default
	wallpaper=$imgsout/$default.xml
	permanent=$background/$default.xml
	echo "'-o' option not provided or provided incorrectly."
	echo "Default output image directory: $imgsout"
	echo "Default filename: wallpaper.xml"
	echo "Default filename: permanent.xml"
fi

echo "The directory: $imgsout"
echo "The file: $wallpaper"
echo "The file: $permanent"
echo "==============================================================="
echo ""

# Create required directory if not exist.
echo "==============================================================="
echo "* Create directory if not exist..."

if [ ! -d $imgsout ]; then
	# Creating directory.
	mkdir -pv $imgsout
fi

if [ ! -d $background ]; then
	mkdir -pv $background
fi
echo "==============================================================="
echo ""

# Copying images.
echo "==============================================================="
echo -e '\tCopying images'
echo "==============================================================="
cp -ruiv $imgsin/* $imgsout/

# Create xml files
/bin/bash $PWD/script/wallpaper.sh $imgsout > $wallpaper
/bin/bash $PWD/script/permanent.sh $wallpaper > $permanent
