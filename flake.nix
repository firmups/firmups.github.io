{
  description = "FIRMUPS device-sdk environment";

  inputs.nixpkgs.url = "github:nixos/nixpkgs?ref=25.05";

  outputs = { self, nixpkgs }:
    let
      supportedSystems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forAllSystems = f: nixpkgs.lib.genAttrs supportedSystems (system:
        f system
      );
    in {
      devShells = forAllSystems (system:
        let
          pkgs = import nixpkgs { inherit system; };
        in {
          default = pkgs.mkShell {
            name = "firmups.github.io";
            buildInputs = with pkgs; [
              nodejs_24
              bashInteractive
            ];
            shellHook = ''
              export PS1="($name)$PS1"
              echo "Welcome to the $name devShell!"
            '';
          };
        }
      );
    };
}
