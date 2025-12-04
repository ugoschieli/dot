{ config, inputs, pkgs, self, primaryUser, myneovim, ... }: {
  imports = [
    inputs.home-manager.darwinModules.home-manager
    inputs.nix-homebrew.darwinModules.nix-homebrew
  ];

  nix-homebrew = {
    enable = true;
    taps = {
      "homebrew/homebrew-core" = inputs.homebrew-core;
      "homebrew/homebrew-cask" = inputs.homebrew-cask;
      "FelixKratz/homebrew-formulae" = inputs.homebrew-felixkratz;
    };
    user = primaryUser;
    mutableTaps = false;
  };

  homebrew = {
    enable = true;
    taps = builtins.attrNames config.nix-homebrew.taps;
    brews = [
      "sketchybar"
    ];
    casks = [
      "leader-key"
    ];
  };

  environment.systemPackages = [];

  system.primaryUser = primaryUser;
  users.users.${primaryUser} = {
    home = "/Users/${primaryUser}";
    shell = pkgs.zsh;
  };

  system.defaults.NSGlobalDomain = { 
    KeyRepeat = 2;
    InitialKeyRepeat = 15;
    "com.apple.swipescrolldirection" = false;
  };

  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToEscape = true;
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
