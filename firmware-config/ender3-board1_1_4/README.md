- AVR atmega1284p
- no other special settings

- Info sources:
  - https://github.com/Klipper3d/klipper/issues/3613
  - https://github.com/Klipper3d/klipper/blob/master/config/printer-creality-ender3-2018.cfg


```
# This file contains common pin mappings for the 2018 Creality
# Ender 3. To use this config, the firmware should be compiled for the
# AVR atmega1284p.

# Note, a number of Melzi boards are shipped with a bootloader that
# requires the following command to flash the board:
#  avrdude -p atmega1284p -c arduino -b 57600 -P /dev/ttyUSB0 -U out/klipper.elf.hex
# If the above command does not work and "make flash" does not work
# then one may need to flash a bootloader to the board - see the
# Klipper docs/Bootloaders.md file for more information.

# See docs/Config_Reference.md for a description of parameters.
```
