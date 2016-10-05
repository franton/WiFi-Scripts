#!/bin/bash

# Script to remove a specifically named WiFi network from the Mac's list of known SSID's

# Set variables here

removessid="$4"

ap="/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport"
wifiport=$( networksetup -listnetworkserviceorder | awk -F' ' '/(Wi-Fi|AirPort)/{print $NF}' | awk -F')' '/^en/{print $1}' )
currentap=$( $ap -I | awk -F': ' '/ SSID/{print $NF}' )

# Are we attached already to it? Detach if we are.

if [ "$currentap" = "$removessid" ];
then
	$ap -z
if

# Remove from the list

networksetup -removepreferredwirelessnetwork "$wifiport" "$removessid"

# All done!

exit 0