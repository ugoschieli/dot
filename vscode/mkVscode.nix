{ stdenv, writeShellScriptBin, vscode, vscode-with-extensions, nix-vscode-extensions }: let
  extensions = with nix-vscode-extensions.vscode-marketplace; [
    vscodevim.vim
    mvllow.rose-pine
    miguelsolorio.fluent-icons
    miguelsolorio.symbols
    anthropic.claude-code
    esbenp.prettier-vscode
    dbaeumer.vscode-eslint
    bradlc.vscode-tailwindcss
    prisma.prisma
    docker.docker
    rust-lang.rust-analyzer
    wgsl-analyzer.wgsl-analyzer 
  ];

  myVscode = vscode-with-extensions.override {
    vscodeExtensions = extensions;
    vscode = vscode;
  };

  settingsJson = ./settings.json;

  wrappedVscode = writeShellScriptBin "code" ''
    ${if stdenv.isDarwin then ''
      CONFIG_DIR="$HOME/Library/Application Support/Code/User"
    '' else ''
      CONFIG_DIR="''${XDG_CONFIG_HOME:-$HOME/.config}/Code/User"
    ''}
    SETTINGS_FILE="$CONFIG_DIR/settings.json"
    
    # Reset settings if --reset-settings flag is passed
    if [ "$1" = "--reset-settings" ]; then
      mkdir -p "$CONFIG_DIR"
      cp ${settingsJson} "$SETTINGS_FILE"
      chmod 644 "$SETTINGS_FILE"
      echo "Settings reset to defaults"
      shift
    elif [ ! -f "$SETTINGS_FILE" ]; then
      mkdir -p "$CONFIG_DIR"
      cp ${settingsJson} "$SETTINGS_FILE"
      chmod 644 "$SETTINGS_FILE"
    fi
    
    exec ${myVscode}/bin/code "$@"
  '';
in
  wrappedVscode
