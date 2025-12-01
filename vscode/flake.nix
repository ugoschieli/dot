{
  description = "My vscode configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, nix-vscode-extensions, ...}: let 
    systems = [ "x86_64-linux" "aarch64-darwin" ];

    forAllSystems = function:
      nixpkgs.lib.genAttrs systems (system:
        function (import nixpkgs {
          inherit system;
          config.allowUnfree = true;
          overlays = [ nix-vscode-extensions.overlays.default ];
        })
      );

  in {
    packages = forAllSystems (pkgs: {
      default = pkgs.callPackage ./mkVscode.nix {};
      # default = pkgs.vscode;
    });
  };
}
