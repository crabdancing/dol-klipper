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
         packages = {
          kingroon-kp3s = pkgs.klipper-firmware.override {
            mcu = "kingroon-kp3s";
            firmwareConfig = ./firmware-config/kingroon-kp3s/config;
          };

          ender3v2-board_4_2_7 = pkgs.klipper-firmware.override {
            mcu = "ender3v2-board4.2.7";
            firmwareConfig = ./firmware-config/ender3v2-board4.2.7/config;
          };

          # Add more targets as needed...
        };

      in {
        inherit packages;
       
        devShells.default = pkgs.mkShell {
          buildInputs = [
            (pkgs.writeShellScriptBin "build-all" ''
              echo Built ${packages.ender3v2-board_4_2_7}
              echo Built ${packages.kingroon-kp3s}

            '')
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

