#!/bin/bash
HOST=[insert host to check for ip here]
IP=$(host -4 ${HOST} | cut -d " " -f 4 | head -n 1) #Query for the current IP set
SEDTEXT=[sed text to use ] #If you are using #BlockStart for the start of your ip block and 21841 for the port: /#BlockStart/,/:21841/c\#Blockstart\nEndpoint = ${IP}:21841
CONFLOCATION=[location of wireguard config] #Usually /etc/wireguard/wg0.conf
SERVICE=[service to restart after configuration change] #Usually wg-quick@wg0

if ! grep -q ${IP} ${CONFLOCATION}; then #If the new IP isn't already in the wireguard config file
	sed -i ${SEDTEXT} ${CONFLOCATION}
	echo "$(date): IP CHANGED TO $IP, ${CONFLOCATION} updated"
	systemctl restart ${SERVICE}
fi

