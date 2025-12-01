{ inputs, pkgs, self, primaryUser, myneovim, ... }: {
  imports = [
    inputs.home-manager.darwinModules.home-manager
  ];

  environment.systemPackages = [];

  system.primaryUser = primaryUser;
  users.users.${primaryUser} = {
    home = "/Users/${primaryUser}";
    shell = pkgs.zsh;
  };

  # home-manager config
  home-manager = {
    useGlobalPkgs = true;
    users.${primaryUser} = {
      imports = [
        ./home.nix
        inputs.sops-nix.homeManagerModules.sops
      ];
    };
    extraSpecialArgs = {
      myneovim = myneovim.packages.aarch64-darwin.default;
    };
  };

  security.pam.services.sudo_local.touchIdAuth = true;

  nix.settings.experimental-features = "nix-command flakes";
  nixpkgs.config.allowUnfree = true;

  # Set Git commit hash for darwin-version.
  system.configurationRevision = self.rev or self.dirtyRev or null;
  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;
  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
}
