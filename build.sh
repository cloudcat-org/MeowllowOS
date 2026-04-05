#!/bin/sh

# check if script is run as root/sudo
if [ "$(id -u)" -ne 0 ]; then
	echo "[Error] Your running permissions are insufficient"
	echo "[Info] Please run this script as root or with sudo"
	exit 1
fi

# check if output directory exists, if not create it
if [ ! -d "output" ]; then
	mkdir -p output
fi

# Install dependencies
. script/install_dependencies.sh

# Clone linux kernel
. script/get_linux_kernel.sh

clear
dialog --menu "🐱 MeowllowOS 🐱 " 10 50 5 \
	"1" "Copy configuration from local machine" \
	"2" "Exit" \
	2>choice

if [ $? -ne 0 ]; then
	echo "[Info] User cancelled the operation"
	rm -f choice
	exit 0
fi

selection=$(cat choice)

rm -f choice

# Handle user selection
case "$selection" in
1)
	# Handle option 1
	clear
	echo "[Info] Copying configuration from local machine..."
	. script/same_environment_kernel_compilation.sh
	;;
2)
	# Handle option 2
	clear
	echo "[Info] Exiting..."
	exit 0
	;;
*)
	# Handle invalid selection
	clear
	echo "[Error] Invalid selection: $selection"
	exit 1
	;;
esac
