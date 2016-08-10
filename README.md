# WiFi-Scripts

This is a collection of various Wifi based scripts that i've worked on.

### Connect to Preferred Network

This takes a list of "preferred" wifi SSID's, will check for their presence and then automatically connect if detected.

There is a supplied launchdaemon that runs periodically every two minutes, and also if any network changes are made via a WatchPath.

### Ethernet On WiFi Off

This detects if ethernet is active and turns off Wi-Fi. When ethernet is disconnected, Wi-Fi is re-enabled.