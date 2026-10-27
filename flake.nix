# run with:                nix develop
# see metadata with:       nix flake metadata
# debug with:              nix repl
#                          :lf .#
# check with:              nix flake check
# If you want to update a locked input to the latest version, you need to ask
# for it:                  nix flake lock --update-input nixpkgs
# show available packages: nix-env -qa
#                          nix search nixpkgs
# show nixos version:      nixos-version
#
 
{
  description = "Python + Pygame + Boot.dev dev environment";

  inputs = {
    nixos-config.url = "github:BerndDonner/NixOS-Config";
    nixpkgs.follows = "nixos-config/nixpkgs";
  };

  outputs = { self, nixpkgs, nixos-config, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ nixos-config.overlays.unstable nixos-config.overlays.pygame-avx2 ];
      };

      # import your shared shell template
      pythonDev = nixos-config.lib.mkPythonDevShell;

    in {
      devShells.${system}.default = pythonDev {
        inherit pkgs;

        flakeLockPath = ./flake.lock;

        inputs = { inherit nixos-config nixpkgs; };
        checkInputs = [ "nixos-config" ];
        symbol = "🐍";
        pythonVersion = pkgs.python3;
        pythonPackages = ps: [ ps.pygame-avx2 ];
        extraPackages = [
          pkgs.go
          nixos-config.packages.${system}.bootdev-cli
          # pkgs.unstable.bootdev-cli #too outdated
        ];
        message = "🐍 Pygame development shell ready";
      };
    };
}

