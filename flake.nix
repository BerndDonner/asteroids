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
  description = "Python + Pygame + Boot.dev dev environment (pure Nix)";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
  };

  outputs = { self, nixpkgs }: {
    devShells.x86_64-linux.default = let
      pkgs = import nixpkgs { system = "x86_64-linux"; };
    in
      pkgs.mkShell {
        name = "python-pygame-bootdev-devshell";

        # All development tools go here
        packages = with pkgs; [
          python311
          python311Packages.pygame
          (pkgs.callPackage ./bootdev.nix {})
        ];

        shellHook = ''
          echo
          echo "🐍 Python + 🎮 Pygame + 🧰 Boot.dev dev environment ready"
          echo "Try: python3 -m pygame.examples.aliens"
          echo "Try: bootdev --help"
          echo
        '';
      };
  };
}

