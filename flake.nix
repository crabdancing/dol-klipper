{
  description = "A flake for building Klipper firmware for various printer boards";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            (self: super: {
              # Here, you might want to create an overlay if necessary
              klipper-firmware = super.callPackage ./klipper-firmware.nix { };
            })
          ];
        };
      in {
        packages.klipper-firmware-atmega2560 = pkgs.klipper-firmware.override {
          mcu = "atmega2560";
          firmwareConfig = ./config/atmega2560.cfg;
        };

        packages.klipper-firmware-stm32f103 = pkgs.klipper-firmware.override {
          mcu = "stm32f103";
          firmwareConfig = ./config/stm32f103.cfg;
        };

        # Add more targets as needed...
      }
    );
}

