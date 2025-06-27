#!/bin/sh
#
# This script is stored within /usr/arduino/extra .
#
# The purpose of this script is to load the kernel
# modules BEFORE flashing/resetting STM32H7. The purpose
# of following modules is to provide basic spi access to STM
# and read firmware version from it.


modprobe x8h7_drv
modprobe x8h7_reset
modprobe x8h7_h7
