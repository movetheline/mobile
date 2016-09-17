#!/bin/bash
# Generate PhoneGap icon and splash screens.
# Copyright 2013 Tom Vincent <http://tlvince.com/contact>

usage() { echo "usage: $0 icon colour [dest_dir]"; exit 1; }

# Example: sh ./image_asset_generation/image_asset_generator.sh image_asset_generation/huge_icon.png "#e4e4e4" ./www

[ "$1" ] && [ "$2" ] || usage
[ "$3" ] || set "$1" "$2" "."

devices=android,ios
eval mkdir -p "$3/res/{icon,screen}/{$devices}"

# Show the user some progress by outputing all commands being run.
set -x

# Explicitly set background in case image is transparent (see: #3)
convert="convert -background none"
$convert "$1" -resize 128x128 "$3/res/icon/icon.png"

$convert "$1" -resize 512x512 "$3/res/icon/android/icon-google-play-store.png"

$convert "$1" -resize 36x36 "$3/res/icon/android/icon-36-ldpi.png"
$convert "$1" -resize 72x72 "$3/res/icon/android/icon-72-hdpi.png"
$convert "$1" -resize 48x48 "$3/res/icon/android/icon-48-mdpi.png"
$convert "$1" -resize 96x96 "$3/res/icon/android/icon-96-xhdpi.png"

$convert "$1" -resize 40x40 "$3/res/icon/ios/icon-40.png"
$convert "$1" -resize 58x58 "$3/res/icon/ios/icon-58.png"
$convert "$1" -resize 76x76 "$3/res/icon/ios/icon-76.png"
$convert "$1" -resize 80x80 "$3/res/icon/ios/icon-80.png"
$convert "$1" -resize 120x120 "$3/res/icon/ios/icon-120.png"
$convert "$1" -resize 152x152 "$3/res/icon/ios/icon-152.png"
$convert "$1" -resize 180x180 "$3/res/icon/ios/icon-180.png"

convert="convert $1 -background $2 -gravity center"
$convert -resize 512x512 -extent 1280x720 "$3/res/screen/android/screen-xhdpi-landscape.png"
$convert -resize 256x256 -extent 480x800 "$3/res/screen/android/screen-hdpi-portrait.png"
$convert -resize 128x128 -extent 320x200 "$3/res/screen/android/screen-ldpi-landscape.png"
$convert -resize 512x512 -extent 720x1280 "$3/res/screen/android/screen-xhdpi-portrait.png"
$convert -resize 256x256 -extent 320x480 "$3/res/screen/android/screen-mdpi-portrait.png"
$convert -resize 256x256 -extent 480x320 "$3/res/screen/android/screen-mdpi-landscape.png"
$convert -resize 128x128 -extent 200x320 "$3/res/screen/android/screen-ldpi-portrait.png"
$convert -resize 256x256 -extent 800x480 "$3/res/screen/android/screen-hdpi-landscape.png"
$convert -resize 256x256 -extent 320x480 "$3/res/screen/ios/screen-iphone-portrait.png"
$convert -resize 256x256 -extent 960x640 "$3/res/screen/ios/screen-iphone-landscape-2x.png"
$convert -resize 256x256 -extent 480x320 "$3/res/screen/ios/screen-iphone-landscape.png"
$convert -resize 512x512 -extent 768x1004 "$3/res/screen/ios/screen-ipad-portrait.png"
$convert -resize 1024x1024 -extent 1536x2008 "$3/res/screen/ios/screen-ipad-portrait-2x.png"
$convert -resize 512x512 -extent 1024x783 "$3/res/screen/ios/screen-ipad-landscape.png"
$convert -resize 256x256 -extent 640x960 "$3/res/screen/ios/screen-iphone-portrait-2x.png"
$convert -resize 1024x1024 -extent 2008x1536 "$3/res/screen/ios/screen-ipad-landscape-2x.png"
$convert -resize 256x256 -extent 640x1136 "$3/res/screen/ios/screen-iphone-portrait-568h-2x.png"
$convert -resize 256x256 -extent 1136x640 "$3/res/screen/ios/screen-iphone-landscape-568h-2x.png"

# iPhone 6
$convert -resize 256x256 -extent 750x1334  "$3/res/screen/ios/Default-667h@2x.png"
$convert -resize 256x256 -extent 1242x2208 "$3/res/screen/ios/Default-Portrait-736h@3x.png"
$convert -resize 512x512 -extent 2208x1242 "$3/res/screen/ios/Default-Landscape-736h@3x.png"