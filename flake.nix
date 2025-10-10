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
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixos-config.url = "nixos-config"; # uses registry entry
  };

  outputs = { self, nixpkgs, nixos-config, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };

      # import your shared shell template
      pythonDev = import "${nixos-config}/lib/python-develop.nix";
    in {
      devShells.${system}.default = pythonDev {
        inherit pkgs;
        symbol = "🐍";
        pythonVersion = pkgs.python311;
        extraPackages = with pkgs.python311Packages; [
          pygame
        ];
        message = "🐍 Pygame development shell ready";
      };
    };
}

