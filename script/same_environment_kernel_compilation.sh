#!/bin/sh

cd clone/linux-kernel-rt || exit 1

cp /boot/config-$(uname -r) .config

make menuconfig
