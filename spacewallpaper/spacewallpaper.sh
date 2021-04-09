#!/bin/bash
body="earth"
location="$( cd "$( dirname "${BASH_SOURCE[0]}" )" > /dev/null && pwd )"
/usr/bin/xplanet -body $body -projection mercator -num_times 1 -geometry 3840x2160 -output ${location}/${body}_3840x2160.png
wait
/usr/bin/gsettings set org.gnome.desktop.background picture-uri ${location}/${body}_3840x2160.png
