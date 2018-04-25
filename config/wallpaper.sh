#!/bin/bash

set -e;

mkdir -p "$HOME/Pictures/Wallpapers";

wallpaper_url="$(wget -O - -o /dev/null "https://www.bing.com/HPImageArchive.aspx?format=xml&idx=1&n=1&mkt=en-US" | grep -oP "(?<=<url>).*(?=</url>)" | awk '{print "https://www.bing.com"$1}')";

wallpaper_name="$(echo "$wallpaper_url" | cut -d'/' -f7 | rev | cut -d'.' -f2- | rev)";

wallpaper_path="$HOME/Pictures/Wallpapers/$wallpaper_name.png";
lock_image_path="$HOME/Pictures/Wallpapers/$wallpaper_name-lock.png";

convert "$wallpaper_url" "$wallpaper_path";

convert -blur 0x5 "$wallpaper_path" "$lock_image_path";

ln -fs "$wallpaper_path" "$HOME/Pictures/wallpaper.png";
ln -fs "$lock_image_path" "$HOME/Pictures/wallpaper-lock.png";
