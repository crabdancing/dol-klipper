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
        firmware-pkgs = pkgs.callPackage ./firmware-pkgs.nix {};
      in
      {
        apps = rec {
          default = build-all;
          build-all = flake-utils.lib.mkApp {
            drv = firmware-pkgs.build-all;
          };
        };
        defaultPackage = firmware-pkgs.build-all;
        packages = firmware-pkgs.klipperFirmwarePackages // {
          build-all = firmware-pkgs.build-all;
        };

        devShells.default = pkgs.mkShell {
          buildInputs = [
            pkgs.klipper
            pkgs.klipper-genconf
            pkgs.klipper-flash  
          ];
          shellHook = ''
            echo "Klipper version: ${pkgs.klipper.version}"
          '';
        };
      }
    );
}

