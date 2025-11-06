#!/bin/sh

# check if dependencies are installed, if not install them
## Declare an array of packages to install
PKGS_TO_INSTALL=""

## Check if the package manager is apt
if command -v apt >/dev/null 2>&1; then
	PM="apt"
	PKGS_TO_INSTALL="dialog build-essential libncurses-dev bison flex libssl-dev libelf-dev bc dwarves zstd"
## Check if the package manager is apk
elif command -v apk >/dev/null 2>&1; then
	PM="apk"
	PKGS_TO_INSTALL="dialog build-base ncurses-dev bison flex openssl-dev elfutils-dev bc dwarves zstd"
## Check if the package manager is pacman
elif command -v pacman >/dev/null 2>&1; then
	PM="pacman"
	PKGS_TO_INSTALL="dialog gcc make ncurses bison flex openssl elfutils bc dwarves zstd"
## Check if the package manager is dnf
elif command -v dnf >/dev/null 2>&1; then
	PM="dnf"
	PKGS_TO_INSTALL="dialog gcc-c++ make ncurses-devel bison flex openssl-devel elfutils-devel bc dwarves zstd"
## Check if the package manager is yum
elif command -v yum >/dev/null 2>&1; then
	PM="yum"
	PKGS_TO_INSTALL="dialog gcc-c++ make ncurses-devel bison flex openssl-devel elfutils-devel bc dwarves zstd"
else
	log "Error" "No supported package manager found."
	exit 1
fi

log "Info" "---------- 🐱 MeowllowOS Build System 🐱 ----------"
log "Info" "Current Package Manager: $PM"
log "Info" "Packages to install:"
log "Info" "$PKGS_TO_INSTALL" | tr ' ' '\n' | sed 's/^/ - /'
log "Info" "---------- 🐱 MeowllowOS Build System 🐱 ----------"

case $PM in
apt)
	apt update
	apt install -y $PKGS_TO_INSTALL
	;;
apk)
	apk update
	apk add --no-cache $PKGS_TO_INSTALL
	;;
pacman)
	pacman -Syu --noconfirm
	pacman -S --noconfirm $PKGS_TO_INSTALL
	;;
dnf)
	dnf check-update || true
	dnf install -y $PKGS_TO_INSTALL
	;;
yum)
	yum check-update || true
	yum install -y $PKGS_TO_INSTALL
	;;
esac

log "Info" "---------- 🐱 MeowllowOS Build System 🐱 ----------"
log "Info" "Dependencies installed successfully."
log "Info" "---------- 🐱 MeowllowOS Build System 🐱 ----------"
