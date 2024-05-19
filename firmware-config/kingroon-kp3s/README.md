- You will need to enable extra-low level config options.
- Set the `Micro-controller Architecture` to `STMicroelectronics STM32`
- Set the `Communication interface` to `USART3 PB11/PB10`
- Set the `microcontroller startup` to `!PC6,!PD13`.


- Info sources:
  - https://kingroon.com/blogs/3d-print-101/how-to-prepare-klipper-firmware-for-kingroon-kp3s-using-fluiddpi

```
1.Enable extra low-level configuration options
2.Set the Bootloader offeset as 28 KiB
3.Set the “Micro-controller Architecture” as “STMicroelectronics STM32”
4.Set the Communication interface as “USART3 PB11/PB10”
5.Enter the last option, enter “!PC6, !PD13”, the. Press enter key
Then press Q and enter “yes”, after that, the setup is done.
```
