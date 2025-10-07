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
  description = "Clean Python + Pygame development environment (pure Nix)";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
  };

  outputs = { self, nixpkgs }: {
    devShells.x86_64-linux.default = let
      # Import nixpkgs for this system
      pkgs = import nixpkgs { system = "x86_64-linux"; };
    in
      pkgs.mkShell {
        name = "python-pygame-env";

        # All tools and libraries available in the shell
        packages = with pkgs; [
          python311
          python311Packages.pygame
          go
        ];

        shellHook = ''
          echo
          echo "🐍 Python + 🎮 Pygame environment ready"
          echo "Try: python3 -m pygame.examples.aliens"
          echo
        '';
      };
  };
}
