#!/bin/sh

#echo 8 > /sys/class/gpio/export # SWDIO
#echo 15 > /sys/class/gpio/export # SWDCLK
#echo 10 > /sys/class/gpio/export # NRST
#echo 11 > /sys/class/gpio/export # BOOT0

X8H7_STATUS_FILE="/sys/kernel/x8h7_firmware/set_up"
WAIT_TIMEOUT=300
TIME_WAITED=0

echo "STARTED - programx8h7"
# Wait for the x8h7_ready file to be created
while [ ! -f "$X8H7_STATUS_FILE" ]; do
    if [ "$TIME_WAITED" -ge "$WAIT_TIMEOUT" ]; then
        echo "Error: Timed out waiting for $X8H7_STATUS_FILE to be created." >&2
        exit 1
    fi
    echo "waiting for file"
    sleep 0.1
    TIME_WAITED=$((TIME_WAITED + 1))
done

cat $X8H7_STATUS_FILE
# Wait for the modules to say all is ready
while [ "$(cat $X8H7_STATUS_FILE)" != "ready" ]; do
    if [ "$TIME_WAITED" -ge "$WAIT_TIMEOUT" ]; then
        echo "Error: Timed out waiting for modules to become ready." >&2
        exit 1
    fi
    echo "Modules not ready yet, waiting..."
    sleep 0.1
    TIME_WAITED=$((TIME_WAITED + 1))
done

sleep 1
# Try at least three times to read firmware version from sysfs
for i in 1 2 3 4 5 6 7 8 9 10
do
    FIRMWARE_H7_ON_MCU=$(cat /sys/kernel/x8h7_firmware/version)
    res=$?
    if [ $res == 0 ]; then
        break
    else
        echo "Failed to read h7 firmware version"
        sleep 0.1
    fi
done

dd if=/usr/arduino/extra/STM32H747AII6_CM7.bin of=/tmp/version bs=1 count=40 skip=$((0x40000))
FIRMWARE_H7_ON_LINUX=$(strings /tmp/version | head -n1)
rm /tmp/version

if [ "$FIRMWARE_H7_ON_MCU" = "$FIRMWARE_H7_ON_LINUX" ]; then
  echo "Firmware on H7 matches firmware stored on X8. No Update."
else
  # remove the module so that reset and boot pin are available for openocd
  rmmod x8h7_reset
  echo "Firmware on H7 does not match firmware stored on X8. Performing Update."
  echo "Version(H7)="$FIRMWARE_H7_ON_MCU
  echo "Version(M8)="$FIRMWARE_H7_ON_LINUX
  openocd -f /usr/arduino/extra/openocd_script-imx_gpio.cfg -c "program /usr/arduino/extra/STM32H747AII6_CM7.bin verify reset exit 0x8000000"
  modprobe x8h7_reset # for a clean reset
fi
