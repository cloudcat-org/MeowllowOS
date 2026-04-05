#!/bin/sh

# Get linux kernel
if ! command -v wget >/dev/null 2>&1; then
	ln -s /bin/busybox /bin/wget
fi

if [ ! -d "clone/linux-kernel-rt" ]; then
	cd clone
	echo "Download linux kernel"
	wget https://git.kernel.org/torvalds/t/linux-7.0-rc6.tar.gz
	mkdir linux-kernel-rt
	tar -xzvf linux-7.0-rc6.tar.gz -C linux-kernel-rt --strip-components=1
	rm linux-7.0-rc6.tar.gz
	cd linux-kernel-rt
	echo "Patch linux kernel"
	wget https://mirrors.edge.kernel.org/pub/linux/kernel/projects/rt/7.0/patch-7.0-rc1-rt1.patch.gz
	tar -xzvf patch-7.0-rc1-rt1.patch.gz
	patch -p1 <patch-7.0-rc1-rt1.patch
	rm patch-7.0-rc1-rt1.patch.gz
	cd ../..
fi
