{ lib, pkgs, klipper-firmware,  ... }:
let

  printerBoards = [
    "ender3-board1_1_4"
    "ender3v2-board4_2_7"
    "kingroon-kp3s"
    "anycubic-chiron"
  ];
in rec {

  mkPrinterBoard = printerBoardName: {
    ${printerBoardName} = klipper-firmware.override {
      mcu = "${printerBoardName}";
      firmwareConfig = ./firmware-config/${printerBoardName}/config;
    };
  };
  klipperFirmwarePackages = lib.foldl' lib.recursiveUpdate { } (builtins.map mkPrinterBoard printerBoards);
  build-all = (pkgs.writeShellScriptBin "build-all" ''
    ${
      lib.concatStringsSep "\n" (builtins.map (printerBoardName: "echo Built ${klipperFirmwarePackages.${printerBoardName}}") printerBoards)
    }
  '');
}
