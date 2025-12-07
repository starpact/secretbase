HISTSIZE=10000
SAVEHIST=10000

setopt HIST_IGNORE_ALL_DUPS
setopt SHARE_HISTORY

bindkey -e

path=(
    $HOME/bin
    $HOME/.cargo/bin
    $HOME/go/bin
    $HOME/.npm-global/bin
    $HOME/.local/bin
    /opt/homebrew/opt/llvm/bin
    /opt/homebrew/bin
    /opt/homebrew/sbin
    $path
)

fpath+=("$(brew --prefix)/share/zsh/site-functions")

autoload -U compinit && compinit

alias gp='git pull'
alias gs='git status'
alias l='ls -hl'
alias la='ls -ahl'
alias ls=eza
alias ta='tmux a'
alias vim=nvim
alias python=python3

source <(fzf --zsh)
eval "$(starship init zsh)"
eval "$(direnv hook zsh)"

if [ -f "~/.private" ]; then
    source "~/.private"
fi
