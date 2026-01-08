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

      # Needed for compiling some rust programs
      "openssl"
      "pkg-config"
    ];
    casks = [
      "ghostty"
      "leader-key"
      "raycast"
      "zen"
      "google-chrome"
      "microsoft-teams"
      "tidal"
      "protonvpn"
      "proton-drive"
      "discord"
      "moonlight"
      "iina"
      "obsidian"
      "utm"
    ];
  };

  environment.systemPackages = with pkgs; [ 
    fish
    libiconv
    dioxus-cli
  ];
  environment.variables = {
    # Add library search paths
    LIBRARY_PATH = "${pkgs.libiconv}/lib";
    # Also set rustflags
    RUSTFLAGS = "-L ${pkgs.libiconv}/lib";
  };

  environment.shells = [ pkgs.fish ];
  programs.fish.enable = true;

  system.primaryUser = primaryUser;
  users.users.${primaryUser} = {
    home = "/Users/${primaryUser}";
  };

  system.activationScripts.postActivation.text = ''
    # Following line should allow us to avoid a logout/login cycle when changing settings
    sudo -u ${primaryUser} /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
    # Set fish as the default shell
    sudo chsh -s /run/current-system/sw/bin/fish ${primaryUser}
    '';

  system.defaults = {
    finder.AppleShowAllFiles = true;
    NSGlobalDomain = { 
      ApplePressAndHoldEnabled = false;
      KeyRepeat = 2;
      InitialKeyRepeat = 15;
      "com.apple.swipescrolldirection" = false;
    };
    CustomUserPreferences = {
      "com.apple.symbolichotkeys" = {
        AppleSymbolicHotKeys = {
          # Disable '^ + Space' for selecting the previous input source
          "60" = { enabled = false; };
          # Disable '^ + Option + Space' for selecting the next input source
          "61" = { enabled = false; };
          # Disable 'Cmd + Space' for Spotlight Search
          "64" = { enabled = false; };
          # Disable 'Cmd + Alt + Space' for Finder search window
          "65" = { enabled = false; };
        };
      };
    };
    controlcenter.BatteryShowPercentage = true;
    dock = {
      autohide = true;
      show-recents = false;
      persistent-apps = [
        { app = "/Applications/Google Chrome.app"; }
        { app = "/Applications/Zen.app"; }
        { app = "/Applications/Ghostty.app"; }
      ];
      persistent-others = [];
    };
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
