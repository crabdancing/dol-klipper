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
        lib = pkgs.lib;
        mkPrinterBoard = printerBoardName: {
          ${printerBoardName} = pkgs.klipper-firmware.override {
            mcu = "${printerBoardName}";
            firmwareConfig = ./firmware-config/${printerBoardName}/config;
          };
        };
        printerBoards = [
          "ender3-board1_1_4"
          "ender3v2-board4_2_7"
          "kingroon-kp3s"
          "anycubic-chiron"
        ];
        klipperVersion = pkgs.klipper.version;
        klipperFirmwarePackages = lib.foldl' lib.recursiveUpdate { } (builtins.map mkPrinterBoard printerBoards);
        buildAllPkg = (pkgs.writeShellScriptBin "build-all" ''
          ${
            lib.concatStringsSep "\n" (builtins.map (printerBoardName: "echo Built ${klipperFirmwarePackages.${printerBoardName}}") printerBoards)
          }
        '');
        toolPackages = {
          build-all = buildAllPkg;
        };

      in
      {
        apps = rec {
          default = build-all;
          build-all = flake-utils.lib.mkApp {
            drv = buildAllPkg;
          };
        };
        defaultPackage = buildAllPkg;
        packages = klipperFirmwarePackages // toolPackages;

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

