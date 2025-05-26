autoload -Uz compinit
compinit
export KEYTIMEOUT=5
bindkey -e

if type brew &>/dev/null; then
    export FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
fi
export FPATH=$HOME/.local/share/zsh-completion/completions:$FPATH

export EDITOR=nvim
export DIFFPROG='nvim -d'
export MANPAGER='nvim +Man!'
export MANWIDTH=999

alias ls='eza -a --git'
alias cat='bat'
alias grep='grep --color=auto'
alias vim='nvim'
alias vimdiff='nvim -d'
alias lg='lazygit'

[ -f "$HOME/.ghcup/env" ] && . "$HOME/.ghcup/env"
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$ANDROID_HOME/emulator:$PATH
export PATH=$ANDROID_HOME/platform-tools:$PATH
export PATH=$HOME/go/bin:$PATH

eval "$(fzf --zsh)"
eval "$(starship init zsh)"
eval "$(mise activate zsh)"
