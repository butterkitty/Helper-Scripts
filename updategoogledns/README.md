# Update Google DNS

## Description
This script will automatically check a dns to see if it matches the server's current internet IP and then update that DNS record automatically if it's a Google Cloud DNS record.

This is fantastic for situations, like wireguard, where you have a dynamic ip, but need static ip related services.

## Requirements
Google Cloud SDK https://cloud.google.com/sdk/docs/install

## Installation
Clone this repo

mv updategoogledns/updategoogledns /usr/share/bin/

## Usage
./updategoogledns [zone] [recordname] [type] [newdata]