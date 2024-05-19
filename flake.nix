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
 
        firmware-pkgs = import ./firmware-pkgs.nix { inherit pkgs lib; };
      in
      {
        apps = rec {
          default = build-all;
          build-all = flake-utils.lib.mkApp {
            drv = firmware-pkgs.buildAllKlipperFirmware;
          };
        };
        defaultPackage = firmware-pkgs.buildAllKlipperFirmware;
        packages = firmware-pkgs.klipperFirmwarePackages // {
          build-all = firmware-pkgs.buildAllKlipperFirmware;
        };

        devShells.default = pkgs.mkShell {
          buildInputs = [
            pkgs.klipper
            pkgs.klipper-genconf
            pkgs.klipper-flash          ];
          shellHook = ''
            echo "Klipper version: ${pkgs.klipper.version}"
          '';
        };
      }
    );
}

