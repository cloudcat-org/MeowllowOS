#!/bin/sh

sudo apt update
sudo apt install -y build-essential bison flex libssl-dev \
    u-boot-tools device-tree-compiler bc kmod cpio \
    git python3 lz4 wget rsync