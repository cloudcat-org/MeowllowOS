#!/bin/sh

# Log function
log() {
	echo "$(date '+%Y-%m-%d %H:%M:%S') [$1] ${2}"
}

# check if script is run as root/sudo
if [ "$(id -u)" -ne 0 ]; then
	log "Error" "Your running permissions are insufficient"
	log "Info" "Please run this script as root or with sudo"
	exit 1
fi

# check if output directory exists, if not create it
if [ ! -d "output" ]; then
	mkdir -p output
fi
