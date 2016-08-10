#!/bin/bash

# Script to toggle the wireless card on/off depending on ethernet connection

# Set toggle for found IP on an interface to FALSE to start
IPFOUND=false

# Get list of possible wired ethernet interfaces
INTERFACES=`networksetup -listnetworkserviceorder | grep "Hardware Port" | grep "Ethernet" | awk -F ": " '{print $3}'  | sed 's/)//g'`

# Get list of Wireless Interfaces
WIFIINTERFACES=`networksetup -listallhardwareports | tr '\n' ' ' | sed -e 's/Hardware Port:/\'$'\n/g' | grep Wi-Fi | awk '{print $3}'`
 
# Look for an IP on all Ethernet interfaces.  If found set variable IPFOUND to true.
for INTERFACE in $INTERFACES
do
  # Get Wired LAN IP (If there is one other then the loopback and the self assigned.)
  IPCHECK=`ifconfig $INTERFACE | egrep 'status: ' | awk '{print $2}'`
  if [ $IPCHECK == "active" ]; then
    IPFOUND=true
  fi
done
 
# This is (so far) working with 10.7 - 10.10 OS versions.
if [ $IPFOUND == "true" ]; then
	/usr/sbin/networksetup -setairportpower $WIFIINTERFACES off
else
	/usr/sbin/networksetup -setairportpower $WIFIINTERFACES on
fi
 
# This sleep prevents LaunchDaemons from thinking the script failed and running it again.
sleep 10