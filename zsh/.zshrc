autoload -Uz compinit
compinit
export KEYTIMEOUT=5
bindkey -e

if type brew &>/dev/null; then
    export FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
fi
export FPATH=$HOME/.local/share/zsh-completion/completions:$FPATH

[ -f "$HOME/.ghcup/env" ] && . "$HOME/.ghcup/env"
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

export STM32_PRG_PATH=/Applications/STMicroelectronics/STM32Cube/STM32CubeProgrammer/STM32CubeProgrammer.app/Contents/MacOs/bin

exec fish
