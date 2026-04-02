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

    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    homebrew-felixkratz = {
      url = "github:FelixKratz/homebrew-formulae";
      flake = false;
    };

    myneovim = {
      url= ./neovim;
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.neovim.follows = "neovim-nightly";
    };
    neovim-nightly = { 
      url = "github:nix-community/neovim-nightly-overlay";
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

  outputs = inputs@{ self, nix-darwin, home-manager, nixpkgs, nix-homebrew, homebrew-core, homebrew-cask, homebrew-felixkratz, myneovim, neovim-nightly, rust-overlay, sops-nix }:
  let
    primaryUser = "ugo";
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
