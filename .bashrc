#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='eza -a --git'
alias cat='bat'
alias grep='grep --color=auto'
alias vim='nvim'
alias bvim='NVIM_APPNAME=bvim nvim'
alias vimdiff='nvim -d'
alias lg='lazygit'

export PATH=~/.local/bin:$PATH
export EDITOR=nvim
export DIFFPROG='nvim -d'

PS1='[\u@\h \W]\$ '
eval "$(starship init bash)"
eval "$(fzf --bash)"
eval $(thefuck --alias)

[ -f "$HOME/.ghcup/env" ] && . "$HOME/.ghcup/env"
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
