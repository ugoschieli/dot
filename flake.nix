{
  description = "Home Manager configuration of ugo";

  inputs = {
    self.submodules = true;

    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    myneovim = {
      url= ./neovim;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, myneovim, rust-overlay, home-manager, ... }:
    let
      system = "aarch64-darwin";
      overlays = [(import rust-overlay)];
      pkgs = import nixpkgs { inherit system overlays; config.allowUnfree = true; };
    in
    {
      homeConfigurations."ugo" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ ./home.nix ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
        extraSpecialArgs = {
          myneovim = myneovim.packages.${system}.default;
        };
      };
    };
}
