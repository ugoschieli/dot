{ config, pkgs, myneovim, ... }:
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "ugo";
  home.homeDirectory = "/Users/ugo";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  home.packages = [
    # cli utils
    pkgs.bat
    pkgs.eza
    pkgs.fd
    pkgs.ripgrep
    pkgs.jq
    pkgs.fzf
    pkgs.tree
    pkgs.wget
    pkgs.tokei
    pkgs.htop
    pkgs.nmap
    pkgs.iproute2mac
    pkgs.gnupg
    pkgs.lz4
    pkgs.age
    pkgs.sops

    # desktop env
    pkgs.zsh-completions
    pkgs.fish
    pkgs.tmux
    myneovim
    pkgs.starship
    pkgs.nerd-fonts.jetbrains-mono

    # gui
    pkgs.ghostty-bin
    pkgs.google-chrome
    pkgs.raycast
    pkgs.discord
    pkgs.iina
    pkgs.obsidian
    pkgs.moonlight-qt
    pkgs.utm

    #dev
    pkgs.bruno
    pkgs.qemu
    pkgs.gitflow
    pkgs.watchman
    pkgs.bear
    pkgs.cmake
    pkgs.ninja
    pkgs.cocoapods
    pkgs.protobuf
    pkgs.openocd
    pkgs.gcc-arm-embedded
    pkgs.bun
    pkgs.pnpm
    pkgs.nodejs
    pkgs.clang
    pkgs.go
    (pkgs.rust-bin.stable."1.91.1".default.override {
      extensions = ["rust-analyzer"];
    })
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
    ".config/starship.toml".source = starship/starship.toml;
    ".config/tmux/tmux.conf".source = tmux/tmux.conf;
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/ugo/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
    DIFFPROG = "nvim -d";
    MANPAGER = "nvim +Man!";
    MANWIDTH = "999";
    ANDROID_HOME = "$HOME/Library/Android/sdk";
  };

  home.sessionPath = [
    "$HOME/go/bin"
    "$ANDROID_HOME/emulator"
    "$ANDROID_HOME/platform-tools"
  ];

  sops = {
    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
    defaultSopsFile = ./secrets/ssh.yaml;
    secrets = {
      gh_perso_key = {
        path = "${config.home.homeDirectory}/.ssh/id_ed25519";
        mode = "0600";
      };
      gh_perso_public_key = {
        path = "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
        mode = "0644";
      };
      gh_epitech_key = {
        path = "${config.home.homeDirectory}/.ssh/epitech";
        mode = "0600";
      };
      gh_epitech_public_key = {
        path = "${config.home.homeDirectory}/.ssh/epitech.pub";
        mode = "0644";
      };
    };
  };

  programs.fish = {
    enable = true;
    shellAliases = {
      ls = "eza";
      cat = "bat";
    };
  };

  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.java = {
    enable = true;
    package = pkgs.zulu17;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
