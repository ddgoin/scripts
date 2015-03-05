#!/bin/bash
# displays a human readable history of apt-get stuff
# useful when needing to uninstall a recently installed set of packages
awk '!/^Start|^Commandl|^End|^Upgrade:|^Error:/ { gsub( /\([^()]*\)/ ,"" );gsub(/ ,/," ");sub(/^Install:/,""); print}' /var/log/apt/history.log
