#!/bin/bash
xml=$1

echo '<?xml version="1.0" encoding="UTF-8"?>'
echo '<!DOCTYPE wallpapers SYSTEM "gnome-wp-list.dtd">'
echo '<wallpapers>'
echo -e '\t<wallpaper deleted="false">'
echo -e '\t\t<name>Nature</name>'
echo -e '\t\t<name xml:lang="de">Firmenhintergrund</name>'
echo -e "\t\t<filename>$xml</filename>"
echo -e "\t\t<filename-dark>$xml</filename-dark>"
echo -e '\t\t<options>zoom</options>'
echo -e '\t\t<shade_type>solid</shade_type>'
echo -e '\t\t<pcolor>#FFFFFF</pcolor>'
echo -e '\t\t<scolor>#000000</scolor>'
echo -e '\t</wallpaper>'
echo '</wallpapers>'
