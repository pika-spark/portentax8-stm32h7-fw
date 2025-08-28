#!/bin/sh
echo "/tmp/arduino/m4-user-sketch.elf changed, triggered m4 programming"
/bin/openocd -f /usr/arduino/extra/openocd_script-imx_gpio.cfg -c "program /tmp/arduino/m4-user-sketch.elf verify reset exit"
echo "M4 programming done"
