autoload -Uz compinit
compinit
export KEYTIMEOUT=5
bindkey -e

if type brew &>/dev/null; then
    export FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
    export PATH=$(brew --prefix)/opt/llvm/bin:$PATH
fi
export FPATH=$HOME/.local/share/zsh-completion/completions:$FPATH

export EDITOR=nvim
export DIFFPROG='nvim -d'
export MANPAGE='nvim +Man!'
export MANWIDTH=999

alias ls='eza -a --git'
alias cat='bat'
alias grep='grep --color=auto'
alias vim='nvim'
alias vimdiff='nvim -d'
alias lg='lazygit'

[ -f "$HOME/.ghcup/env" ] && . "$HOME/.ghcup/env"
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
export JAVA_HOME=/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$HOME/go/bin

eval "$(fzf --zsh)"
eval "$(starship init zsh)"
