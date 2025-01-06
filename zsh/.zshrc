if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
    export PATH=/opt/homebrew/opt/llvm/bin:$PATH
fi
FPATH=$HOME/.local/share/zsh-completion/completions:$FPATH

autoload -Uz compinit
compinit
bindkey -v
export KEYTIMEOUT=5

export EDITOR=nvim
export DIFFPROG='nvim -d'

alias ls='eza -a --git'
alias cat='bat'
alias grep='grep --color=auto'
alias vim='nvim'
alias vimdiff='nvim -d'
alias lg='lazygit'

[ -f "$HOME/.ghcup/env" ] && . "$HOME/.ghcup/env"
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

eval "$(fzf --zsh)"
eval "$(starship init zsh)"
