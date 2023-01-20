# Fix Stylus Input

## Description
When using multiple monitors in systems using xinput, mainly Linux, the system isn't able to automatically find what surface is a touch input area for any stylus. This is especially bad for drawing as the point touched by the pen and the cursor can be full centimeters away, depending on how lard the total screen area is vs the touch area.

This script will automatically, based on user input, calibrate this so the cursor position matches pen position

## Known limitations
Does not work where monitors are stacked vertically.

Must be run every reboot

## Requirements
xinput and xrandr

## Installation
Clone this repo

## Usage
./fixStylusInput.sh

(NOTE: This will need to be done every time your monitor layout changes and every time you reboot your computer)

## Sources
https://wiki.archlinux.org/title/Calibrating_Touchscreen
