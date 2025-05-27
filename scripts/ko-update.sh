#!/bin/sh
sudo rmmod x8h7_can
sudo mv *.ko /lib/modules/5.10.93-lmp-standard/updates/
sudo modprobe x8h7_can

