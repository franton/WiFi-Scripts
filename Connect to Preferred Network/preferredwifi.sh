#!/bin/bash

# Script to scan for WiFi networks, and attach to a specific corporate one.

# Set variables here

preferredap[0]="cwifi-ch"
preferredap[1]="cwifi-uk"
preferredap[2]="cwifi-us"
preferredap[3]="cwifi-sg"
preferredap[4]="cwifi-hk"
preferredap[5]="cwifi-jp"
preferredap[6]="cwifi-au"

ap="/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport"
wifiport=$( networksetup -listnetworkserviceorder | awk -F' ' '/(Wi-Fi|AirPort)/{print $NF}' | awk -F')' '/^en/{print $1}' )
aptest="false"

# Is WiFi enabled? Quit gracefully if not.

currentap=$( $ap -I | awk -F': ' '/ SSID/{print $NF}' )

if [ "$currentap" = "" ];
then
	echo "WiFi is disabled. Exiting."
	exit 0
fi

# Is our preferred network in that list anywhere? No, then quit.

wifiscan=$( $ap -s )

for (( i=0; i<${#preferredap[@]}; i++ ));
do
	test=$( echo $wifiscan | grep "$preferredap[i]" | wc -l )
	
	if [ "$test" -gt 0 ];
	then
		aptest="true"
		break
	fi
done

if [ "$aptest" = "false" ];
then
	echo "SSID $preferredap[i] is not available. Exiting."
	exit 0
fi

# Are we attached already to it? Quit if we are.

if [ "$currentap" = "$preferredwifi[i]" ];
then
	echo "Already connected to: $preferredap[i] . Exiting."
	exit 0
if

# Detach from existing network, connect to preferred network

$ap -z
networksetup -setairportnetwork $wifi $preferredap[i]

# All done!

exit 0