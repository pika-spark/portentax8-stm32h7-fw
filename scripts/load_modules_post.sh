#!/bin/sh
#
# This script is stored within /usr/arduino/extra .
#
# The purpose of this script is to load the kernel
# modules allowing to access the extended IO interfaces
# provided by the STM32H7.


modprobe industrialio
modprobe x8h7_can
modprobe x8h7_gpio
modprobe x8h7_adc
modprobe x8h7_rtc
modprobe x8h7_pwm
modprobe x8h7_uart
modprobe x8h7_ui
