- Compile with:
 - STM32F103
 - 28KiB bootloader
 - Serial USART1 PA10/PA9

- Info source:
  - https://github.com/Klipper3d/klipper/blob/master/config/generic-creality-v4.2.7.cfg


```
# This file contains pin mappings for the Creality "v4.2.7" board. To
# use this config, during "make menuconfig" select the STM32F103 with
# a "28KiB bootloader" and serial (on USART1 PA10/PA9) communication.

# If you prefer a direct serial connection, in "make menuconfig"
# select "Enable extra low-level configuration options" and select
# serial (on USART3 PB11/PB10), which is broken out on the 10 pin IDC
# cable used for the LCD module as follows:
# 3: Tx, 4: Rx, 9: GND, 10: VCC

# Flash this firmware by copying "out/klipper.bin" to a SD card and
# turning on the printer with the card inserted. The firmware
# filename must end in ".bin" and must not match the last filename
# that was flashed.

# See docs/Config_Reference.md for a description of parameters.
```

