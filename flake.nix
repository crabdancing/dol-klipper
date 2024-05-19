# {
#   description = "A flake for building Klipper firmware for various printer boards";

#   inputs = {
#     nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
#     flake-utils.url = "github:numtide/flake-utils";
#   };

#   outputs = { self, nixpkgs, flake-utils }:
#     flake-utils.lib.eachDefaultSystem (system:
#       let
#         pkgs = import nixpkgs {
#           inherit system;
#         };
#       in {
#         packages.klipper-firmware-atmega2560 = pkgs.klipper-firmware.override {
#           mcu = "atmega2560";
#           firmwareConfig = ./config/atmega2560.cfg;
#         };

#         packages.klipper-firmware-stm32f103 = pkgs.klipper-firmware.override {
#           mcu = "stm32f103";
#           firmwareConfig = ./config/stm32f103.cfg;
#         };

#         # Add more targets as needed...
#       }
#     );
# }

{
  description = "A flake for building Klipper firmware for various printer boards";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
        klipperVersion = pkgs.klipper.version;
      in {
        packages = {
          klipper-firmware-atmega2560 = pkgs.klipper-firmware.override {
            mcu = "atmega2560";
            firmwareConfig = ./config/atmega2560.cfg;
          };

          "klipper-firmware-ender3v2-board_4_2_7" = pkgs.klipper-firmware.override {
            mcu = "stm32f103";
            firmwareConfig = ./firmware-config/ender3v2-board4.2.7;
          };

          # Add more targets as needed...
        };

        devShells.default = pkgs.mkShell {
          buildInputs = [
            (pkgs.klipper.overrideAttrs (oldAttrs: {
              version = klipperVersion;
            }))
            (pkgs.klipper-genconf.overrideAttrs (oldAttrs: {
              version = klipperVersion;
            }))
            (pkgs.klipper-flash.overrideAttrs (oldAttrs: {
              version = klipperVersion;
            }))
          ];

          shellHook = ''
            echo "Klipper version: ${klipperVersion}"
          '';
        };
      }
    );
}

