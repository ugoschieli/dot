{
  description = "Example nix-darwin system flake";

  inputs = {
    self.submodules = true;

    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    myneovim = {
      url= ./neovim;
      inputs.nixpkgs.follows = "nixpkgs";
    };

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nix-darwin, home-manager, nixpkgs, myneovim, rust-overlay, sops-nix }:
  let
    primaryUser = "ugo";
    # system = "aarch64-darwin";
    # overlays = [(import rust-overlay)];
    # pkgs = import nixpkgs { inherit system overlays; config.allowUnfree = true; };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#bite
    darwinConfigurations."bite" = nix-darwin.lib.darwinSystem {
      modules = [
        { nixpkgs.overlays = [ rust-overlay.overlays.default ]; }
        ./darwin.nix
      ];
      specialArgs = { inherit inputs self primaryUser myneovim; };
    };
  };
}
