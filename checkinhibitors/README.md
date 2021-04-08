# checkinhibitors

![image](https://user-images.githubusercontent.com/481603/114101858-57c45b00-9894-11eb-910a-a7754500d693.png)

## Description
It's important your computer goes to happens since it saves a lot in power usage for something we use all the time, but aren't using during other times. This is a net benefit for your pocket book and the planet!

This script parses GNOME dbus output to find out what power mode inhibitors exist.  These inhibitors will disallow certain GNOME Desktop functionality on your computer (eg. logging out or going to sleep).  Currently there is not easily readable way for the average person to be able to access why their computer failed to sleep overnight.  This script was made with the intension of filling that gap in the linux ecosystem.

## Requirements
GNOME Desktop

## Install
clone repository
sudo mv checkinhibitors/checkinhibitors /usr/local/bin
sudo chmod +x /usr/local/bin/checkinhibitors

## Usage
Run: checkinhibitors
