# Space Wallpaper Updater

## Description
This script will automatically run the software xplanet to download an image of the earth (or really most heavenly bodies) with the area daylight covering it calculated for current time of day to the same folder where the script is located.  Then the script sets it as the current wallpaper in the GNOME Desktop system.


## Requirements
xplanet http://xplanet.sourceforge.net
GNOME Desktop

http://xplanet.sourceforge.net/maps.php You can use your own maps with xplanet too! This area gives you access to free, high quality, maps!

## Installation
Clone this repo and run ./spacewallpaper.sh 

If you would like it to automatically update your background throughout the day, paste the following into your user's crontab, replacing for where the file is located on your drive:

```*/5 * * * * <path to file>/spacewallpaper.sh >/dev/null 2>&1```

This will update your background every 5 minutes with a newly calculated image.